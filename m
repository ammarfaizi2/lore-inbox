Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266637AbSKGWpe>; Thu, 7 Nov 2002 17:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266635AbSKGWpe>; Thu, 7 Nov 2002 17:45:34 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:53405 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S266637AbSKGWpd>;
	Thu, 7 Nov 2002 17:45:33 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: davem@redhat.com
Date: Thu, 7 Nov 2002 23:52:01 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Preempt count check when leaving IRQ? (Was: Re: 2.5.44 
Cc: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org,
       roger.larsson@skelletftea.mail.telia.com
X-mailer: Pegasus Mail v3.50
Message-ID: <6DEAE382FC9@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 Nov 02 at 1:41, Roger Larsson wrote:
> 
> This is another CHECK to do then.
> 
> Make a copy of preempt count when entering an IRQ.
> Check that we have the same value when leaving.
> (using -acX we only have to add the check when leaving)

Hi Dave,
  I have bad news for you: doing 'cat /proc/net/arp' sometime kills
my system hard.

  Problem is with reading /proc/net/arp: arp_seq_start does
read_lock_bh(&arp_tbl.lock), and this lock is held and held and held...
as long as neigh_get_bucket() returns non-NULL, or until reading
of /proc/net/arp stops...

... and so it sometime happens that lock is still held when accessing 
userspace while copying data in read, and shortly after that we run
userspace with (1) this lock held and (2) bh disabled, and scheduler
does not like such configuration.

I'd say that all machines here are affected, and only I suffer
from problem because of I'm running shell script which periodically pings
all machines on subnet, reading their ethernet addresses back from 
/proc/net/arp...

Unfortunately I do not have any idea how to fix it correctly, so for now
I just removed /proc/net/arp from my system, because of 'cat /proc/net/arp'
preceded by ping is quickest way I know to kill my system from user account.
                                        Thanks,
                                            Petr Vandrovec
                                            vandrove@vc.cvut.cz
                                            
