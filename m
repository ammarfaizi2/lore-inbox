Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263390AbTETA5H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbTETA5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:57:07 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12041 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263390AbTETA5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:57:00 -0400
Message-ID: <3EC9803F.6010701@zytor.com>
Date: Mon, 19 May 2003 18:09:19 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: Recent changes to sysctl.h breaks glibc
References: <20030519165623.GA983@mars.ravnborg.org>	 <Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com>	 <babhik$sbd$1@cesium.transmeta.com>	<m1d6ie37i8.fsf@frodo.biederman.org>	 <3EC95B58.7080807@zytor.com> <m18yt235cf.fsf@frodo.biederman.org>	 <3EC9660D.2000203@zytor.com> <1053392095.21582.48.camel@imladris.demon.co.uk>
In-Reply-To: <1053392095.21582.48.camel@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> To a large extent, however, it merely grows. And in a lot of cases when
> it grows due to new syscalls, new interfaces, etc., you have to add
> matching code to glibc to use them _anyway_, so it's no problem for
> glibc's version of the headers to lag behind until the appropriate
> support is added.
> 

... unless you need the new feature, may it be an ioctl to support your
device driver, or whatnot.

Most ABI changes do not require

> You are, however, correct that the correct fix is to have completely
> separate headers which define the ABI. Then the real kernel headers in
> include/linux and include/asm can include them, and C libraries can also
> use them without contamination.
> 
> This requires that someone sit down and cut'n'paste large amounts of
> structures and definitions from include/linux/*.h into the new header
> files. I've been tempted to do that on occasion but what's held me up
> has been the fact that there isn't yet a consensus on how it should be
> laid out.

I maintain the proposal I have given before:

<linux/abi/*.h> as the header file namespace;
<linux/*.h> <asm/*.h> namespaces reserved for compatibility (once the
migration is complete these are owned by the libc)

Types use the __kernel_* namespace *only*; structures use struct __kernel_*.

Some form of export of the expected syscall ABI as well as syscall
numbering.

> For compatibility with older libc, one approach would be to add a new
> directory to the include path which matches the existing layout
> (linux/usrinclude/linux, linux/usrinclude/asm-*), and use #include_next
> from the actual kernel headers to pull in those files.
>
> Alternatively, we could go further and take the opportunity to rearrange
> stuff further; I'm not sure what we really gain from that though other
> than extra pain.

I don't think the <linux/*.h> namespace as its currently laid out is
very functional for exporting ABIs, so I'd like to

A bigger issue is if this really should be done in C.  A worthwhile
thought: if this is done correctly then most or all of the 64/32 compat
code (or any other arch1-on-arch2 compatibility) should be able to be
automatically generated.  If not, it almost certainly isn't done
correctly...

> If Linus would approve a strategy for rearranging the headers such that
> people can work on it without suspecting that they're just wasting their
> time, I think it could get done for 2.6.
> 
> It's not the kind of thing you do in private and present as a fait
> accomplis -- if it isn't quite right, you end up having to do the whole
> thing from scratch, afaict.

Agreed.

	-hpa

