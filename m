Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289730AbSAJWBs>; Thu, 10 Jan 2002 17:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289719AbSAJWBk>; Thu, 10 Jan 2002 17:01:40 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:8348 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S289721AbSAJWBc>;
	Thu, 10 Jan 2002 17:01:32 -0500
Date: Thu, 10 Jan 2002 22:01:24 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: f.jimenez@bigfoot.com, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: array size limit in module?
Message-ID: <1471199855.1010700083@[195.224.237.69]>
In-Reply-To: <20020110181054Z289122-13997+3040@vger.kernel.org>
In-Reply-To: <20020110181054Z289122-13997+3040@vger.kernel.org>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is the offending part of code:
>
> char *sectors_array = NULL;
> ........
> secs_size=131072;
> sectors_array = kmalloc(secs_size*sizeof(char), GFP_KERNEL);

    <===== missing check: if (!sectors_array) ....

> for(i=0; i<secs_size; i++) {
> 	sectors_array[i]=0;

You appear to be missing something that checks for
(even transient) out of memory conditions.

kmalloc() has an internal sensible limit to
allocations of 128Mb (see mm/slab.c, cache_sizes
array). It BUG()s if >128Mb is asked for.
You can get more with __get_free_pages()
and/or vmalloc().

In any case, kmalloc has to allocate contiguous
pages, whilst there may be 4 pages free, there may not be
4 contiguous pages free. This aside, kmalloc()
may /still/ fail.

However, if you are reading sectors probably
wise to group them by page and allocate
each page separately.

--
Alex Bligh
