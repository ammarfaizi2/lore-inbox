Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbUJ3VBI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbUJ3VBI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbUJ3VBI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:01:08 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:9229 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261316AbUJ3VBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:01:05 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Semaphore assembly-code bug
Date: Sun, 31 Oct 2004 00:00:38 +0300
User-Agent: KMail/1.5.4
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <200410301228.42561.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.58.0410301040050.28839@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410301040050.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 October 2004 20:53, Linus Torvalds wrote:
> > > > 	movl 4(%esp),%ecx
> > > > 	movl 8(%esp),%edx
> > > > 	movl 12(%esp),%eax
> > > > 	addl $16,%esp
> > > > 
> > > > which is also one of the biggest alternatives.
> > > 
> > > For K8 it should be the fastest way. K7 probably too.
> > 
> > Pity. I always loved 1 byte insns :)
> 
> I personally am a _huge_ believer in small code. 

Thankfully you are not alone - a horde of uclibc/dietlibc/busybox
users shares these views. Also see http://smarden.org/pape/

> The sequence
> 
> 	popl %eax
> 	popl %ecx
> 	popl %edx
> 	popl %eax
> 
> is four bytes. In contrast, the three moves and an add is 15 bytes. That's 
> almost 4 times as big.
> 
> And size _does_ matter. The extra 11 bytes means that if you have six of
> these sequences in your program, you are pretty much _guaranteed_ one more
> icache miss from memory. That's a few hundred cycles these days.  
> Considering that you _maybe_ won a cycle or two each time it was executed,
> it's not at all clear that it's a win, except in benchmarks that have huge
> repeat-rates. Real life doesn't usually have that. In many real-life
> schenarios, repeat rates are in the tens of hundreds for most code...

If only glibc / X / KDE / OpenOffice (ugggh) people could hear you more...

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
15364 root      15   0 38008  26M 28496 S     0,0 10,8   0:57   0 kmail
20022 root      16   0 40760  24M 23920 S     0,1 10,0   0:04   0 mozilla-bin
 1627 root      14  -1 71064  19M 53192 S <   0,1  7,9   3:16   0 X
 1700 root      15   0 25348  16M 23508 S     0,1  6,5   0:46   0 kdeinit
 3578 root      15   0 24032  14M 21524 S     0,5  5,8   0:23   0 konsole
--
vda

