Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318749AbSICKLp>; Tue, 3 Sep 2002 06:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318747AbSICKLp>; Tue, 3 Sep 2002 06:11:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24531 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318741AbSICKLn>;
	Tue, 3 Sep 2002 06:11:43 -0400
Date: Tue, 03 Sep 2002 03:09:17 -0700 (PDT)
Message-Id: <20020903.030917.77257624.davem@redhat.com>
To: ak@suse.de
Cc: kuznet@ms2.inr.ac.ru, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       haveblue@us.ibm.com, Manand@us.ibm.com, christopher.leech@intel.com
Subject: Re: TCP Segmentation Offloading (TSO)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020903121041.A20066@wotan.suse.de>
References: <p73y9ajqw85.fsf@oldwotan.suse.de>
	<20020903.030025.07037175.davem@redhat.com>
	<20020903121041.A20066@wotan.suse.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Tue, 3 Sep 2002 12:10:41 +0200

   On Tue, Sep 03, 2002 at 03:00:25AM -0700, David S. Miller wrote:
   > Ok I think we really need to fix this then in the arches
   > where broken.  Let's do an audit. :-)
   
   Yes, it's needed because users can pass unaligned addresses in from
   userspace to sendmsg
   
I know, that is old news.  New case is csum_partial since
sys_sendfile can use byte aligned page offsets.

Traditionally this really didn't ever happen because
skb->data was always nicely aligned.

   > It looks like sparc64 is the only platform where oddly aligned buffer
   > can truly cause problems and I can fix that easily enough.
   
   It could allow everybody to generate packets with bogus addresses on 
   the network.
   
No, the sparc64 case generates an OOPS for csum_partial only.

csum_partial_copy_*() is perfectly fine for byte aligned buffers.

   I suspect on sparc64 it will just be all handled by the unalignment handler
   in the kernel ? If yes it will be incredibly slow, but should work.
   
That's what happens now as long as the VIS instructions don't
get used.  The one case where oddly aligned buffer address is
not checked to avoid using VIS is csum_partial.

The unaligned trap handler doesn't handle the 64-byte VIS loads into
the fpu regs from kernel mode, and this is by choice.  I'd rather back
down to an integer algorithm than actually handle this odd case.
