Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316788AbSHTKY0>; Tue, 20 Aug 2002 06:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316792AbSHTKY0>; Tue, 20 Aug 2002 06:24:26 -0400
Received: from [62.40.73.125] ([62.40.73.125]:18402 "HELO Router")
	by vger.kernel.org with SMTP id <S316788AbSHTKYZ>;
	Tue, 20 Aug 2002 06:24:25 -0400
Date: Tue, 20 Aug 2002 12:28:16 +0200
From: Jan Hudec <bulb@cimice.maxinet.cz>
To: Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: Pages swapped out even when free memory available...
Message-ID: <20020820102816.GC6981@vagabond>
Mail-Followup-To: Jan Hudec <bulb@cimice.maxinet.cz>,
	Jean-Eric Cuendet <Jean-Eric.Cuendet@linkvest.com>,
	linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
References: <61FEFD6522F0F142B36E3F6CE511A4F01D37CC@hermes.linkvest.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61FEFD6522F0F142B36E3F6CE511A4F01D37CC@hermes.linkvest.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2002 at 09:53:40AM +0200, Jean-Eric Cuendet wrote:
> Hi,
> I have a program in which I manage myself the swapping of elements from memory to disk.
> So I dont want the kernel to swap out some pages. Ill do it if quite no more free memory is available.

Don't do it. In user-land, you simply don't have the info kernel does.
Gimp tries to do things like this and results are truly horrible.
It forces machine in deep swap if you set the cache large, while with
small cache the actual size does not matter much as kernel takes care of
the real caching.

You should rather open a file you want to swap in, mmap it and only keep
minimum data in other memory. Only reason to do even this may be, that
the data may get too large to fit in swap. For all other reasons you
should just let kernel do it's work.

> I tried to use MAP_LOCKED when calling mmap, but without success. Is it implemented in Linux?
> Is there a way to lock pages in memory so they are not swapped?

You need to be root to lock pages in memory, since nasty DOS attacks are
possible when you can lock pages in memory.

> Is there a way to say to the kernel to reload swapped out pages back in memory?

Read it.

> If I read back all my memory, will all the swap be back in the memory?

It may not even fit in! Ususaly the swap space is larger then memory and
malloc will happily give you blocks that don't fit in memory.

> Is it enough to read ione byte/page to reload the entire page in memory?

Yes.

> Is it possible to tell the kernel the maximum amount of disk cache it
> should use?

No. Because term "disk cache" is not even well defined in linux.

There is just a page cache. Pages in the page cache can be mapped (to
any number processes, including none) and they can be anonymous or part
of files (which is orthogonal to mapping). The most recently used pages
are always kept in, no matter weather they are mapped and no matter
weather they belong to files. It's simple and efficient. And it's a
reason why it does not pay to try to be clever. Just rely on it to do
it's work.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
