Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317085AbSEXEOi>; Fri, 24 May 2002 00:14:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317084AbSEXEOi>; Fri, 24 May 2002 00:14:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14600 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314106AbSEXEOh>;
	Fri, 24 May 2002 00:14:37 -0400
Message-ID: <3CEDBF30.1FACBE15@zip.com.au>
Date: Thu, 23 May 2002 21:18:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: linux-fsdevel@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] loop.c forgot a kmap
In-Reply-To: <20020523232024.A2917@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> The patch below fixes a bug in loop.c that causes highmem systems
> to fail spectacularly when a page happens to be allocated in highmem
> by replacing the use of page_address with a kmap/kunmap sequence.

You must be using a funny kernel, or you have loop on a funny address_space.

The current ->prepare_write() API definition requires that the page be kmapped.
By ->prepare_write.  So it appears that the real bug is actually in whatever
you've mounted your loop on.

Now, Linus (I think) decided that this wasn't a good API and moves were made
to change it.  Note how generic_file_write() kmaps the page as well.  So
we're currently kmapping pages twice on such rare operations as writing
to an ext2 file ;)

So right now, it's unclear whether the kmap should be done by prepare/commit,
or whether it should be done by the caller.  I started to clean it up. Al
disagreed with Linus.  I went and did something else.


-
