Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbVKUR0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVKUR0L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbVKUR0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:26:11 -0500
Received: from p-mail2.rd.francetelecom.com ([195.101.245.16]:46858 "EHLO
	p-mail2.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S932375AbVKUR0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:26:08 -0500
Message-ID: <4382032D.4080606@francetelecom.com>
Date: Mon, 21 Nov 2005 18:26:05 +0100
From: VALETTE Eric RD-MAPS-REN <eric2.valette@francetelecom.com>
Reply-To: eric2.valette@francetelecom.com
Organization: Frnace Telecom R&D
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve French <smfrench@austin.rr.com>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.com
Subject: Re: CIFS improvements/wider testing needed
References: <4381EFF3.8000201@austin.rr.com>
In-Reply-To: <4381EFF3.8000201@austin.rr.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Nov 2005 17:26:06.0310 (UTC) FILETIME=[A79C5860:01C5EEC0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve French wrote:
> Eric,
> Thanks for the feedback - any bugs which you report which I can
> reproduce - I will treat
> as a very high priority and your testing is helpful.

I know you have tried to reproduce them and failed. The question was how
to go further?

>> Trying to push Linux in corporate environments in such condition is
>> very difficult because, due to those bugs, you cannot:
>> 
>> 1) save a new openoffice document twice, 2) create mail folders
>> from inside thunderbird (local mailbox
> shared
>> with windows),
> 
> You can avoid these by mounting with "nobrl" (no remote byte range
> lock) mount option (smbfs does not send byte range locks so would not
> run into this problem, but would run into others). These appear to be
> byte range locking problems. The problem is that cifs has to map
> advisory to mandatory locks which only works if the application is
> reasonably well behaved (not even Samba has support for advisory
> locks although they will come with the new Unix extensions). It may
> be made worse by a bug in openoffice (some Linux apps such as
> Evolution lock on the "wrong" file handle which does not fail in
> posix, although is sloppy coding) but I have not confirmed the byte
> range lock sequence which openoffice is trying as we did with
> Evolution - I did confirm that nobrl (disabling the byte range locks
> on the client) works. Note that this mount option, although not
> listed as a bug fix in git per-se - was added to address the
> evolution etc. locking bugs. There are quite a few of the cifs
> changes that fall into that category.

Well I would be surprised the "cat >> titi" command does any of this
byte range lock. If the "create and later rewrite the same file"
sequence fails, with a simple cat command (cat > titi ... ^D; cat >>
titi), how can it works with complicated applications?


> 
>> 3) avoid to do FSCK after each reboot,
> Not sure that cifs would cause this unless you mean that cifs was
> hung and shutdown hung. 

Yes : the system hangs when shutting down as the result of the "umount
-a"  with the last message being as described in bug N° 3237. I have to
press power button for 5 seconds.

NB : manually doing the umount does exactly the same things.

> To avoid cases where cifs requests could stay
> blocked forever (especially locking requests), I added a umount_begin
> routine a few weeks ago to try to free threads blocked in cifs - but
> what I need from users/tests if they see a cifs umount fail is to 
> know where the requests are hung so I can add wakeup calls for that
> condition in cifs's umount_begin (you can do "echo t >
> /proc/sysrq-trigger" then "dmesg > debugdata" to get the debugdata
> which has the callstacks of processes blocked in kernel).

Will do that in the bug data.

>> <https://bugzilla.samba.org/show_bug.cgi?id=3237>

> Although I would like to find a workaround so it does not hang the 
> umount or fail umount I am not convinced that this is a typical
> regression - if a server sends an illegal response which we were not
> catching before ... it would be dangerous to call preventing that
> potential security problem a regression.

Hanging a system systematically leading to FSCK on each reboot is not
particularly helpfull given the fact that it happens whebn you are doing
a shutdown in most cases.


-- eric

