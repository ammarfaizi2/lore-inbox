Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274241AbRISWwJ>; Wed, 19 Sep 2001 18:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274242AbRISWv7>; Wed, 19 Sep 2001 18:51:59 -0400
Received: from pc-62-30-67-185-az.blueyonder.co.uk ([62.30.67.185]:18670 "EHLO
	kushida.degree2.com") by vger.kernel.org with ESMTP
	id <S274241AbRISWvo>; Wed, 19 Sep 2001 18:51:44 -0400
Date: Wed, 19 Sep 2001 23:51:53 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "Andrew V. Samoilov" <kai@cmail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap successed but SIGBUS generated on access
Message-ID: <20010919235153.A22429@kushida.degree2.com>
In-Reply-To: <200109191657.f8JGvPJ06663@cmail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109191657.f8JGvPJ06663@cmail.ru>; from kai@cmail.ru on Wed, Sep 19, 2001 at 08:57:25PM +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew V. Samoilov wrote:
>> It is possible to do something useful with a signal handler sometimes.
>> For example, you can mmap() a zero page into the offending page once
>> you've got the fault address, or read() a zero page if you did
>> MAP_PRIVATE (this produces fewer VMAs), set a flag, and let the program
>> continue until it checks the flag and aborts the parsing or whatever
>> operation it's doing.
> 
> So, I must read all of the mapped area and even this
> does not saves me of faulting next time if somebody
> change file permission. Does I understand this situation
> right?

If you use MAP_PRIVATE, then after your process modifies the mapped
page, you have the data for sure.  This includes calling read() over a
page that raises a SIGBUS -- the page is "modified" by this operation,
although the contents should hopefully be the correct file contents if
read() succeeds.  Any subsequent change to the file, including
permission changes and data changes, won't affect the data you have in
memory.

If you do not modify the pages (and usually, for efficiency, you
wouldn't), then yes a change in file permissions can mean you can read
data one second and will get a SIGBUS later.  You're not guaranteed to
get a SIGBUS, but you might get one -- it depends on whether the OS
decides to reclaim the page's memory temporarily in between.

If you want to do something like an Editor's "Load File" operation, then
you need to read the whole file.  Either call read(), or call mmap() and
then modify every page by reading one byte from each page and writing
the same value back to the same place.  read() is probably quicker, but
I've never checked.

-- Jamie
