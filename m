Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263098AbTJPQ3K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 12:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263201AbTJPQ3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 12:29:10 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:8585
	"EHLO velociraptor.random") by vger.kernel.org with ESMTP
	id S263098AbTJPQ3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 12:29:07 -0400
Date: Thu, 16 Oct 2003 18:29:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Erik Mouw <erik@harddisk-recovery.com>, Josh Litherland <josh@temp123.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031016162926.GF1663@velociraptor.random>
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F8D6417.8050409@pobox.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Wed, Oct 15, 2003 at 11:13:27AM -0400, Jeff Garzik wrote:
> Josh and others should take a look at Plan9's venti file storage method 
> -- archival storage is a series of unordered blocks, all of which are 
> indexed by the sha1 hash of their contents.  This magically coalesces 
> all duplicate blocks by its very nature, including the loooooong runs of 
> zeroes that you'll find in many filesystems.  I bet savings on "all 
> bytes in this block are zero" are worth a bunch right there.

I had a few ideas on the above.

if the zero blocks are the problem, there's a tool called zum that nukes
them and replaces them with holes. I use it sometime, example:

andrea@velociraptor:~> dd if=/dev/zero of=zero bs=1M count=100
100+0 records in
100+0 records out
andrea@velociraptor:~> ls -ls zero
102504 -rw-r--r--    1 andrea   andrea   104857600 2003-10-16 18:24 zero
andrea@velociraptor:~> ~/bin/i686/zum zero
zero [820032K]  [1 link]
andrea@velociraptor:~> ls -ls zero
   0 -rw-r--r--    1 andrea   andrea   104857600 2003-10-16 18:24 zero
andrea@velociraptor:~> 

if you can't find it ask and I'll send it by email (it's GPL btw).

the hash to the data is interesting, but 1) you lose the zerocopy
behaviour for the I/O, it's like doing a checksum for all the data going to
disk that you normally would never do (except for the tiny files in reiserfs
with tail packing enabled, but that's not bulk I/O), 2) I wonder how much data
is really duplicate besides the "zero" holes trivially fixable in userspace
(modulo bzImage or similar where I'm unsure if the fs code in the bootloader
can handle holes ;).
