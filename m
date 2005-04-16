Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262637AbVDPFSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbVDPFSq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Apr 2005 01:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbVDPFSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Apr 2005 01:18:46 -0400
Received: from mail28.sea5.speakeasy.net ([69.17.117.30]:42403 "EHLO
	mail28.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S262637AbVDPFSn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Apr 2005 01:18:43 -0400
Date: Fri, 15 Apr 2005 22:18:42 -0700 (PDT)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Hacksaw <hacksaw@hacksaw.org>
cc: linux-os@analogic.com, "Theodore Ts'o" <tytso@mit.edu>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Tomko <tomko@haha.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Why system call need to copy the date from the userspace before
  using it
In-Reply-To: <200504160450.j3G4oqC9029496@hacksaw.org>
Message-ID: <Pine.LNX.4.58.0504152209260.18492@shell3.speakeasy.net>
References: <200504160450.j3G4oqC9029496@hacksaw.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Apr 2005, Hacksaw wrote:

> Sorry if this bugs anyone, but I'm learning things here.
>
> What I would expect the kernel to do is this:
>
> system_call_data_prep (userdata, size){
>
>    if !4G/4G {
>       for each page from userdata to userdata+size
>       {
>  	if the page is swapped out, swap it in
> 	if the page is not owned by the user process, return -ENOWAYMAN
> 	otherwise, lock the page
>       }
>       return userdata;
>     }
>     else { //kernel land and userland are mutually exclusive
> 	   copy the data into kernel land
> 	   return kernelland_copy_of_userdata;
>           }
> }
>
> (And then the syscall would need to run the opposite function
> sys_call_data_unprep to unlock pages.)
>
> Hmm, maybe that interface sucks.

That's one approach. Unfortunately, it's not what the kernel currently
does. The root of the problem is -- it needs to copy the data, even if
the kernel can access userspace data. There are many reasons for why
this is a simpler way to program the interface; if you want actual
concrete examples, let me know.

In order to accomplish the copy_from_user() procedure, from the i386
perspective, the kernel first figures out where userspace is telling it
to look for the data buffer. It checks if the LAST page belongs to
userland, and fails if not; this works because the kernel sits in higher
memory. Then it simply does the direct copy. If during the copy it hits
an invalid page, the exception handler code will run, realize that the
exception occurred because of the copy, and return an error code right
then and there.

Lots of details left out, but this is the 10,000 foot view, I think.

-Vadim Lobanov

> Is it anything close to that?
>
> --
> The best is the enemy of the good  -- Voltaire
> The Good Enough is the enemy of the Great -- Me
> http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
