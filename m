Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269688AbTGVGgZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 02:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269750AbTGVGgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 02:36:25 -0400
Received: from soft.uni-linz.ac.at ([140.78.95.99]:52426 "EHLO
	zeus.soft.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id S269688AbTGVGfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 02:35:51 -0400
Message-ID: <3F1CDE99.6000505@gibraltar.at>
Date: Tue, 22 Jul 2003 08:50:01 +0200
From: Rene Mayrhofer <rene.mayrhofer@gibraltar.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: de-at, de-de, en-gb, en-us
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: linux-kernel@vger.kernel.org
Subject: Re: pivot_root seems to be broken in 2.4.21-ac4
References: <3F1C52B7.3040308@gibraltar.at> <200307220622.h6M6MTj20460@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200307220622.h6M6MTj20460@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Denis,

[Please CC me in replies, I am currently not subsribed to this list.]

Denis Vlasenko wrote:
>         btw you probably have to remove leading / ^^^
These calls are still within the old root, so it should IMHO be ok.

>><snip>
>>exit 0
> 
> 
> Hm... I thought you are running with pid 1 and have to do
> 
> exec chroot . /sbin/init <dev/console >/dev/console 2>&1
> 
> or the like as a final command.
I am not using pivot_root for switching from an initrd to the real root 
fs in this case, but I use it to switch roots on the fly during 
run-time. Specifically, I have defined a maintainance runlevel with the 
root fs being a harddisk partition and a normal runlevel with the rootfs 
being a (read-only) cramfs (constructed from the harddisk partition). 
This allows the machine (which basically acts as a router and does a few 
other neats things) to switch off the harddisk during normal operation 
(running completely off RAM), but also allows very simple changes in 
maintainance mode. Switching between those modes only means that the 
daemons need to be stopped for a few seconds, but all network 
connections stay alive because the kernel keeps running.

The scripts for doing the on-the-fly root fs switch are working quite 
well by now, but with 2.4.21-ac4 I have the described problem. It worked 
perfectly with 2.4.21-rc2.

> See? fd 3 is open to /dev/initctl in init AND in kernel daemons.
> I conclude that daemons simply share fd table with init.
> 
> So you might try to do the exec chroot . /sbin/init trick
> and see whether that works.
I tell init to re-execute itself (after pivot_root and thus from the new 
root fs), which causes init to close its old fds and open new ones from 
the new root fs with. This is necessary because init already runs as pid 
1 when I start the root fs switching. Maybe something changed with the 
kernel process fds from 2.4.21-rc2 to 2.4.21-ac4 ?

best regards,
Rene



