Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262966AbTC1M6T>; Fri, 28 Mar 2003 07:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262967AbTC1M6T>; Fri, 28 Mar 2003 07:58:19 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:33967 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S262966AbTC1M6R>; Fri, 28 Mar 2003 07:58:17 -0500
Message-Id: <200303281308.h2SD8bGi011390@locutus.cmf.nrl.navy.mil>
To: Duncan Sands <baldrick@wanadoo.fr>
cc: linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ATM] second pass at fixing atm spinlock 
In-reply-to: Your message of "Fri, 28 Mar 2003 11:07:07 +0100."
             <200303281107.07586.baldrick@wanadoo.fr> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 28 Mar 2003 08:08:37 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200303281107.07586.baldrick@wanadoo.fr>,Duncan Sands writes:
>I'm kind of confused about this.  It seems to me that you should only
>need to read_lock(vcc_sklist_lock) if you are going to traverse (or
>otherwise examine the structure of) the list.  There should be no need

to prevent trouble with walking a list that might be changing while
you are walking it and to synchronize the release and "bottom half"
operation of the atm drivers.  i came up with this as the worst
possible case (of course its one of those lookup via big index table
drivers):

driver->open()		BH()		vcc_release()		sk.refcnt

ENTER
...
vcc_hold(vcc)								2
rx_vcc->vcc = vcc
...
EXIT
		ENTER
		read_lock(sklist)
		vcc = rx_vcc->vcc
		...			
					ENTER
					driver->close()
						...
						rx_vcc->vcc = NULL
						barrier()
						vcc_put(vcc)		1
					...
					write_lock(sklist) [MUST WAIT]
						
		vcc_hold(vcc)						2
		read_unlock(sklist)
		...
					...
					vcc_remove_socket()
					write_unlock(sklist)
					sock_put(vcc);			1
					EXIT

		...
		vcc->push(skb)
		vcc_put(vcc)						0
		EXIT

if you didnt read_lock(sklist) then vcc_release() could (it is somewhat
unlikely) unhash the socket and vcc_put() (its really just sock_put) before
the BH has a chance to vcc_hold(vcc).  the { vcc = rx_vcc->vcc; vcc_hold(vcc); }
isnt an atomic operation and that is were you run into trouble.  you
could remove the hold/put for for the table references and this still
works but putting the vcc in the table is a reference.  you should count it.
however, the nicstar/idt77252 probably still have a race since 
the vc && vc->vcc in the BH isnt protected.

>Why does this exist at all?  I mean, if someone has already opened a vcc for
>a given vpi/vci pair, the ATM layer could detect this itself and return an error,
>without ever calling the driver's open method.  Is it sometimes useful to open

mitch and i have had this discussion.  it seems like its probably a good
idea to move this to the upper layer and possibly remove the ATM_ANY_VPI/VCI
functionality.  it probably should be claim_ci, and insert the entry into
the list during operation.  as it stands there is still a race beween
find_ci() and vcc_insert_socket().
