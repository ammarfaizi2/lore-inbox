Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314096AbSHBNpB>; Fri, 2 Aug 2002 09:45:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSHBNo5>; Fri, 2 Aug 2002 09:44:57 -0400
Received: from host194.steeleye.com ([216.33.1.194]:61705 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S314096AbSHBNor>; Fri, 2 Aug 2002 09:44:47 -0400
Message-Id: <200208021348.g72Dm7q03058@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: suparna@in.ibm.com
cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, axboe@kernel.org,
       B.Zolnierkiewicz@elka.pw.edu.pl, akpm@zip.com.au
Subject: Re: [PATCH] Bio Traversal Changes 
In-Reply-To: Message from Suparna Bhattacharya <suparna@in.ibm.com> 
   of "Fri, 02 Aug 2002 18:05:13 +0530." <20020802180513.A1802@in.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 02 Aug 2002 08:48:06 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The SCSI changes (small that they are) look reasonable.

This does look like it exposes an existing problem in the tag/barrier 
approach, though.

The bio can be split by making multiple requests over segements of the bio, 
correct?  If this is a BIO_RW_BARRIER, then each of these requests will be a 
REQ_BARRIER.  However, in the SCSI paradigm where we translate REQ_BARRIER to 
ordered tag, each of the requests will get a new ordered tag as it comes back 
around through end_that_request_first, potentially allowing other tags to be 
inserted in between these, which would be incorrect, since other bios would be 
inserted in between the segments of this one, thus violating the barrier.

Is the above correct?  If it is, I may have finally found a use for linked 
scsi tasks (gives you the ability to have one tag cover multiple commands).

James


