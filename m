Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261698AbVAXWcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbVAXWcA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVAXWaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:30:18 -0500
Received: from mailhost.cs.clemson.edu ([130.127.48.6]:22711 "EHLO
	cs.clemson.edu") by vger.kernel.org with ESMTP id S261587AbVAXW14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:27:56 -0500
Message-ID: <41F5764B.8050308@cs.clemson.edu>
Date: Mon, 24 Jan 2005 17:27:23 -0500
From: Mike Westall <westall@cs.clemson.edu>
User-Agent: Mozilla/5.0 (X11; U; SunOS i86pc; en-US; rv:1.4) Gecko/20040414
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: chas williams - CONTRACTOR <chas@cmf.nrl.navy.mil>
CC: Lukasz Trabinski <lukasz@oceanic.wsisiz.edu.pl>,
       linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Bartlomiej Solarz <solarz@wsisiz.edu.pl>
Subject: Re: [Linux-ATM-General] Kernel 2.6.10 and 2.4.29 Oops fore200e (fwd)
References: <200501241837.j0OIbAE7011717@ginger.cmf.nrl.navy.mil>
In-Reply-To: <200501241837.j0OIbAE7011717@ginger.cmf.nrl.navy.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-CPSC-Clemson-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You could also just revert to kernel 2.4.25 or
earlier.  Someone who was apparently oblivious
to the fact that device driver send routines
were "routinely" called in irq context and/or
that it was a <very bad thing> to call schedule()
under such circumstances slipped that one in
sometime between 2.4.25 which is OK and 2.4.28
where it is broken.

In 2.4.25 and earlier it was a simple busy wait loop
in which "goto retry_here;" immediately followed
the "if" statement.  This was safe, albeit MP unfriendly
because of the spin_lock()/unlock() on each iteration.

I'd say just delete the if and drop the damn
packet.

At any rate someone who has access to the golden code
should fix this one way or another ASAP because its
definitely seriously broken the way it is now.

Mike


chas williams - CONTRACTOR wrote:
> In message <Pine.LNX.4.61L.0501210835270.6993@lt.wsisiz.edu.pl>,Lukasz Trabinsk
> i writes:
> 
>>Sorry, but I don;t understand, what line, i am not kernel guru. :/
> 
> 
> look for the following code:
> 
>            /* retry once again? */
>             if(--retry > 0) {
>                 schedule();
>                 goto retry_here;
>             }
> 
> 
> change schedule() to udelay(50) and see if things are 'better'.
> 
> 
>>Is was happened on 2.4.29, too. It is a interrupt problem?
> 
> 
> its calling a routine that might sleep while in the transmit routine.
> this is not allow.
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Linux-atm-general mailing list
> Linux-atm-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-atm-general
> 
> 


