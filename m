Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKPUX6>; Thu, 16 Nov 2000 15:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129076AbQKPUXs>; Thu, 16 Nov 2000 15:23:48 -0500
Received: from wirex.com ([208.161.110.91]:12548 "HELO mail.wirex.com")
	by vger.kernel.org with SMTP id <S129069AbQKPUXi>;
	Thu, 16 Nov 2000 15:23:38 -0500
Date: Thu, 16 Nov 2000 11:52:49 -0800
From: jesse <jesse@wirex.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.18pre21
Message-ID: <20001116115249.A8115@wirex.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <E13u4XD-0001oe-00@the-village.bc.nu> <20001116150704.A883@emma1.emma.line.org> <20001116171618.A25545@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001116171618.A25545@athlon.random>; from andrea@suse.de on Thu, Nov 16, 2000 at 05:16:18PM +0100
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2000 at 05:16:18PM +0100, Andrea Arcangeli wrote:
> On Thu, Nov 16, 2000 at 03:07:04PM +0100, Matthias Andree wrote:
> > It shows a program that saves the cwd -- open(".",...) in an open file,
> > then chroots [..]
> 
> This is known behaviour (I know Alan knows about it too), solution is to close
> open directories filedescriptors before chrooting.
> 
> Everything that happens before chroot(2) is trusted, so it's secure to rely
> on it to close directories first.
> 
> If this is not well documented and people doesn't know about it and so they
> writes unsafe code that's another issue...

But the problem is because you can call chroot when you're already chrooted.

So what happens is--

1.  Your server closes all open directory file descriptors and chroots.
2.  Someone manages to run some exploit code in your process space which--

  1.  Makes a directory inside the current chroot jail.
  2.  Acquires a file descriptor for the root of the current chroot jail.
  3.  Chroots to the directory that was just created.
  4.  Uses this exploit to pull itself out of the second chroot jail, which 
      also breaks it out of the original chroot jail as well.

It's simply not good enough to close all directory file descriptors before chrooting.

If calling chroot once you're already in a chroot jail was disallowed, it would stop
this attack.

-Jesse
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
