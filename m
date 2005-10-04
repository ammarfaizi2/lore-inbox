Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbVJDTAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbVJDTAw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVJDTAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:00:52 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60049 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964920AbVJDTAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:00:51 -0400
Date: Tue, 4 Oct 2005 20:00:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Vladimir V. Saveliev" <vs@namesys.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS Mailing List <reiserfs-list@namesys.com>,
       Hans Reiser <reiser@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
Message-ID: <20051004190048.GA30832@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Vladimir V. Saveliev" <vs@namesys.com>,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ReiserFS Mailing List <reiserfs-list@namesys.com>,
	Hans Reiser <reiser@namesys.com>
References: <432AFB44.9060707@namesys.com> <20050916174028.GA32745@infradead.org> <43380DD8.8010200@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43380DD8.8010200@namesys.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2005 at 07:03:52PM +0400, Vladimir V. Saveliev wrote:
> >  - you still do your plugin mess in ->readpage.  honsetly could you
> >    please explain why mpage_readpage{,s} don't work for you?
> 
> The reason is performance. Reiser4 uses a search through the filesystem tree to
> access metadata of a file.
> If reiser4 implemented its read/write via generic functions it would have to
> repeat the search for every page being read/written.
> It is especially disappointing because reiser4 uses extents with which it is
> able in most cases to find all file pointers to data blocks with only one search
> through the tree.
> Another reason is multithread load.
> Tree search includes complex part of providing correct concurrent read/write
> access to the tree including deadlock avoidance algorithm. On multithread
> filesystem load minimizing of a number of tree searches should have improved
> filesystem throughput.
> 
> These are on todo list yet.

Let's start with the read side.  You are using the generic sendfile now
which is the same as the generic read routine as far as the filesystem
is concerned.  What more do you need for read performance than a proper
mpage_readpage(s) that can use the extent-enabled get_blocks callback?
I'll post a patch for that ASAP, it benefits the other filesystems aswell.

I know the write path is more complex, and doing your on ->writepage(s)
is fine because that may need to do a lot of FS-specific things.  I'd
really like to see you use generic_file_write or at least the major
routines it's built from.  What's missing for you to do that?  Note
that you read/write path will need a major rewrite anyway due to the
flaws I pointed out, and I think it would benefit both you (less
maintaince overhead, feature and bug parity) and the other
filesystem/vfs/vm hackers (less duplicate functionality to worry about,
improvement you make shared by every filesystem) if you tried to
converge to use common code.


