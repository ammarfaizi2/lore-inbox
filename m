Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262835AbTJPRKh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 13:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262909AbTJPRKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 13:10:37 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17573 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262835AbTJPRKe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 13:10:34 -0400
Message-ID: <3F8ED0FC.9070706@pobox.com>
Date: Thu, 16 Oct 2003 13:10:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Erik Mouw <erik@harddisk-recovery.com>, Josh Litherland <josh@temp123.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random>
In-Reply-To: <20031016162926.GF1663@velociraptor.random>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> Hi Jeff,
> 
> On Wed, Oct 15, 2003 at 11:13:27AM -0400, Jeff Garzik wrote:
> 
>>Josh and others should take a look at Plan9's venti file storage method 
>>-- archival storage is a series of unordered blocks, all of which are 
>>indexed by the sha1 hash of their contents.  This magically coalesces 
>>all duplicate blocks by its very nature, including the loooooong runs of 
>>zeroes that you'll find in many filesystems.  I bet savings on "all 
>>bytes in this block are zero" are worth a bunch right there.
> 
> 
> I had a few ideas on the above.
> 
> if the zero blocks are the problem, there's a tool called zum that nukes
> them and replaces them with holes. I use it sometime, example:
> 
> andrea@velociraptor:~> dd if=/dev/zero of=zero bs=1M count=100
> 100+0 records in
> 100+0 records out
> andrea@velociraptor:~> ls -ls zero
> 102504 -rw-r--r--    1 andrea   andrea   104857600 2003-10-16 18:24 zero
> andrea@velociraptor:~> ~/bin/i686/zum zero
> zero [820032K]  [1 link]
> andrea@velociraptor:~> ls -ls zero
>    0 -rw-r--r--    1 andrea   andrea   104857600 2003-10-16 18:24 zero
> andrea@velociraptor:~> 

Neat.


> the hash to the data is interesting, but 1) you lose the zerocopy
> behaviour for the I/O, it's like doing a checksum for all the data going to
> disk that you normally would never do (except for the tiny files in reiserfs
> with tail packing enabled, but that's not bulk I/O), 2) I wonder how much data
> is really duplicate besides the "zero" holes trivially fixable in userspace
> (modulo bzImage or similar where I'm unsure if the fs code in the bootloader
> can handle holes ;).

FWIW archival storage doesn't really care...  Since all data written to 
disk is hashed with SHA1 (sha1 hash == block's unique id), you gain (a) 
duplicate block coalescing and (b) _real_ data integrity guaranteed, but 
OTOH, you lose performance and possibly lose zero-copy.

I _really_ like the checksum aspect of Plan9's archival storage (venti).

As Andre H and Larry McVoy love to point out, data isn't _really_ secure 
until it's been checksummed, and that checksum data is verified on 
reads.  LM has an anecdote (doesn't he always?  <g>) about how BitKeeper 
-- which checksums its data inside the app -- has found data-corrupting 
kernel bugs, in days long past.

	Jeff


