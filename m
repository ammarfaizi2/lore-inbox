Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318075AbSFTAj4>; Wed, 19 Jun 2002 20:39:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318076AbSFTAjz>; Wed, 19 Jun 2002 20:39:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42763 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318075AbSFTAjz>;
	Wed, 19 Jun 2002 20:39:55 -0400
Message-ID: <3D112401.6975E890@zip.com.au>
Date: Wed, 19 Jun 2002 17:38:25 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.23 mpage io vs queue_max_sectors
References: <20020620002105.GL25360@holomorphy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> 
> This has been haunting me for a while on a 4 cpu Sequent S-quad with
> 4GB of RAM, and a tray of 12 9GB DCHS09X's attached to a QLogicISP1020.
> People keep saying "hands off" ... so here I am passing the buck.
> 
> Kernel BUG at ll_rw_blk.c:1639

This is happening because we have BIO_MAX_SIZE = 64k,
but that particular driver doesn't like requests which are
that big.

This is the issuewhich Adam, Jens and I have been discussing.
Looks like the preferred solution is an add_page_to_bio() API
in the block layer.

But it's not there yet, so in the short-term, please just do

-#define MPAGE_BIO_MAX_SIZE BIO_MAX_SIZE
+#define MPAGE_BIO_MAX_SIZE 16384

in fs/mpage.c

-
