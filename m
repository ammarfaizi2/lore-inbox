Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262451AbTFBPX6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 11:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbTFBPX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 11:23:58 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:42721 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262451AbTFBPX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 11:23:57 -0400
Date: Mon, 2 Jun 2003 17:36:56 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: matsunaga <matsunaga_kazuhisa@yahoo.co.jp>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] 1/2 central workspace for zlib
Message-ID: <20030602153656.GA679@wohnheim.fh-wedel.de>
References: <20030530144959.GA4736@wohnheim.fh-wedel.de> <002901c32919$ddc37000$570486da@w0a3t0>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <002901c32919$ddc37000$570486da@w0a3t0>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 June 2003 00:15:56 +0900, matsunaga wrote:
> 
> But I still would like to stick to performance.
> (Though I haven't evaluated the performance yet...)
> So far I think MTD is used mostly on Embedded device, 
> in which single CPU which is not so powerful is used.
> 
> How is the following code (it is ugly though)?
> 
> static void default_workspace[WSIZE];
> 
> <snip>
> 
>     size = MAX(sizeof(struct inflate_workspace),
>         sizeof(struct deflate_workspace));
> 
>     if(WSIZE < size)
>         BUG();
> 
>     zlib_workspace[0] = default_workspace;
> 
>     for (i=1; i<smp_num_cpus; i++) {
>         zlib_workspace[i] = vmalloc(size);
>         if (!zlib_workspace[i]) {
>             zlib_exit();
>             return -ENOMEM;
>         }
>    }

Not bad.  We can even do a little better.  Since only one workspace is
really absolutely necessary (ignoring the siftirq case), there is no
need to fail anymore.  If we don't get enough memory for all
workspaces, initialize the semaphore to be a little lower and live
with fewer workspaces.

I like your ideas, really! :)

> There is another vmalloc in mtdblock_open()...;-)

...that is not trivial to get rid of.  Image the case where two
processes are writing to two devices.  With two buffers, we do rmew
whenever switching blocks for one device.  With one buffer, we have to
do it for every context switch between those two processes, which will
wear down the flash a lot faster.

Considering that mtdblock should not be performance critical in
production use anyway, this is a very hard problem.  What do you
think?

Jörn

-- 
The only real mistake is the one from which we learn nothing.
-- John Powell
