Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264218AbUENBgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264218AbUENBgl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 21:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbUENBgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 21:36:41 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:50703 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264218AbUENBgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 21:36:36 -0400
Date: Fri, 14 May 2004 11:35:43 +1000
From: Nathan Scott <nathans@sgi.com>
To: David Martinez Moreno - RedIRIS <david.martinez@rediris.es>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org,
       clubinfo.servers@adi.uam.es
Subject: Re: Crashes possibly related to XFS fs.
Message-ID: <20040514113542.A445608@wobbly.melbourne.sgi.com>
References: <200405131116.24487.david.martinez@rediris.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200405131116.24487.david.martinez@rediris.es>; from david.martinez@rediris.es on Thu, May 13, 2004 at 11:16:23AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

On Thu, May 13, 2004 at 11:16:23AM +0200, David Martinez Moreno - RedIRIS wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 	Hello. Since 2.6-preX series we are using XFS filesystem in the Spanish
>  Debian mirror. The machine is under load most of the time, and I think that
>  our periodic crashes (most of them occur only after some hours of operation,
>  some in a couple of days) could be related to the main data filesystem.
> 
> 	For example, today I rebooted the server. All is working, well, with FTP and
>  HTTP concurrent access, and then I run the periodic script to sync up with
>  official Debian mirrors. It is a recursive rsync over the whole tree, over 96
>  GB of size. Now it's running 2.6.6 vanilla. The crash is:
> ...
> May 12 15:21:17 ulises kernel: EIP is at xfs_count_page_state+0x31/0x8a

> May 12 15:21:18 ulises kernel:  [linvfs_release_page+52/156] linvfs_release_page+0x34/0x9c
> May 12 15:21:18 ulises kernel:  [try_to_release_page+81/107] try_to_release_page+0x51/0x6b
> ...

Hmm... that is an odd one.  It looks like its crashing at
the first point we peek into a buffer_head attached to the
page given to xfs_count_page_state... the bh->state access
within buffer_uptodate here:

        bh = head = page_buffers(page);
        do {
                if (buffer_uptodate(bh) 

The page passed to releasepage is guaranteed locked and with
buffers attached, so there doesn't seem to me to be anything
XFS could have done wrong here - I suspect you may have some
memory problems (hardware) or else XFS is being called with
a page in an invalid state.  I can't see anywhere that that
might be happening though - both of the try_to_release_page
callers guarantee the page states I described above.

Running memtest for awhile seems to be the done thing in this
situation, see if that detects any problems.
> 
> 	Oh, and Nathan (if you are in charge of it), in the MAINTAINERS file there is 
> an "owner-xfs@oss.sgi.com" address for XFS, that replies with an error, could 
> you please either fix the address of fix the file? :-)

I'll look into that, thanks.

cheers.

-- 
Nathan
