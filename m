Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287177AbSBCNmA>; Sun, 3 Feb 2002 08:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287193AbSBCNlu>; Sun, 3 Feb 2002 08:41:50 -0500
Received: from zok.SGI.COM ([204.94.215.101]:2738 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S287177AbSBCNli>;
	Sun, 3 Feb 2002 08:41:38 -0500
Message-ID: <3C5D3DE9.4080503@sgi.com>
Date: Sun, 03 Feb 2002 07:40:57 -0600
From: Stephen Lord <lord@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Garzik <garzik@havoc.gtf.org>
CC: Chris Mason <mason@suse.com>, Andrea Arcangeli <andrea@suse.de>,
        Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@zip.com.au>,
        Ricardo Galli <gallir@uib.es>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT fails in some kernel and FS
In-Reply-To: <E16WkQj-0005By-00@antoli.uib.es> <3C5AFE2D.95A3C02E@zip.com.au> <1012597538.26363.443.camel@jen.americas.sgi.com> <20020202093554.GA7207@tapu.f00f.org> <234710000.1012674008@tiny> <20020202205438.D3807@athlon.random> <242700000.1012680610@tiny> <3C5C4929.5080403@sgi.com> <20020202155028.B26147@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>On Sat, Feb 02, 2002 at 02:16:41PM -0600, Stephen Lord wrote:
>
>>Can't you fall back to buffered I/O for the tail? OK it complicates the
>>code, probably a lot, but it keeps things sane from the user's point of
>>view.
>>
>
>For O_DIRECT, IMHO you should fail not fallback.  You're simply lying
>to the underlying program otherwise.
>

By fallback I mean't just for the tail, not the whole file.

I have been there before. I had to implement the mixed mode buffered/direct
I/O on Unicos because a change in underlying disk subsystems stopped
customer applications from working - the allowed boundaries for
O_DIRECT stopped working when the sales people sold them some new
disks. This also meant you could get most of the speed benefits of
O_DIRECT without having to align your I/O, it also meant really
large I/Os could be made to automatically bypass cache to avoid
cache thrashing.

What we had were two flags, one which indicated use direct I/O, and another
which indicated return an error to user space rather than go through 
buffers.
So lie to me and make it work, or don't lie to me options I suppose.

>
>
>In the ibu fs I am hacking on, the idea for O_DIRECT is to fail a read
>if the file is small enough to fit in the inode.  If the O_DIRECT
>action is a write, then I will invalidate the data in the inode,
>then follow the standard path (which eventually calls get_block()).
>
>For file tails (a different case from small-file-in-inode), I
>imagine it would be prudent to support O_DIRECT for all actions
>except reading the file tail.  If you want to be complicated, you
>could provide userspace with a way to say "this is a dense file"
>and/or simply not create a tail at all...
>
I suspect the reason XFS never did small files in the inode was because of
the problems with implementing mmap and O_DIRECT.

>
>	Jeff
>
>
Steve


