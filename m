Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265420AbSKDF1g>; Mon, 4 Nov 2002 00:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265422AbSKDF1c>; Mon, 4 Nov 2002 00:27:32 -0500
Received: from keyaki.cc.u-tokai.ac.jp ([150.7.3.4]:43746 "HELO
	keyaki.cc.u-tokai.ac.jp") by vger.kernel.org with SMTP
	id <S265420AbSKDF1a>; Mon, 4 Nov 2002 00:27:30 -0500
Date: Mon, 4 Nov 2002 14:34:01 +0900
From: Naohiko Shimizu <nshimizu@keyaki.cc.u-tokai.ac.jp>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFC] Transparent SuperPage Support for 2.5.44
Message-Id: <20021104143401.1d5f08ad.nshimizu@keyaki.cc.u-tokai.ac.jp>
In-Reply-To: <20021103074002.GA4189@zaurus>
References: <20021028105849.424265cb.nshimizu@keyaki.cc.u-tokai.ac.jp>
	<20021103074002.GA4189@zaurus>
Organization: Tokai University
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 3 Nov 2002 08:40:10 +0100
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > This is a transparent superpage support patch for 2.5.44.
> > Big difference between this patch and 2.4.19 patch is
> > eliminating of automatic dynamic downgrade for superpages.
> > Instead, I place pagesize adjust routine where required.
> > I hope this change minimize the overhead for conventional
> > programs which does not use superpages.
> > 
> > Linux SuperPage patch is transparent for user applications.
> > It will automatically allocate appropriate size of superpages
> > if possible.
> > It does not allocate real strage unless the application
> > really access that area. And it does not allocate memory
> > larger than the application requests.
> > 
> > This patch includes i386, alpha, sparc64 ports.
> > But I could not compile for alpha even with plain 2.5.44, and
> > I don't have sparc64 to test, then only i386 was tested now.
> 

> How do you swap these 4mb beasts?

With this feature, when kernel needs to swap superpages, 
it will first downgrade the page down to a basic page 
before swapping.
Then we don't need to handle 4MB page for swapping.
I think that if we need to swap some pages, we should not
keep the superpage.

> And you need 4mb, physically continuous
> area for this to work, right? How do you
> get that?

I use buddy allocator of Linux. What I modifed on the
conventional buddy system is only the max order for x86.
Because normal buddy system of Linux only handle upto 2^9 size
of a page, and I need 2^10 for 4MB page on x86.
If buddy system does not have enough 4MB block when required,
we will downgrade the request to use 4KB page on x86 and
512KB page on Alpha or sparc64. We recuresively downgrade
the requesting page size down to the basic page size or
the size that buddy can allocate it.

-- 
Naohiko Shimizu
Dept. Communications Engineering/Tokai University
1117 Kitakaname Hiratsuka 259-1292 Japan
TEL.+81-463-58-1211(ext. 4084) FAX.+81-463-58-8320
http://shimizu-lab.dt.u-tokai.ac.jp/
