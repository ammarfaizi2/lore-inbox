Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284902AbSAPSHS>; Wed, 16 Jan 2002 13:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285666AbSAPSHI>; Wed, 16 Jan 2002 13:07:08 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:676 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S284902AbSAPSGw>;
	Wed, 16 Jan 2002 13:06:52 -0500
From: Janet Morgan <janetmor@us.ibm.com>
Message-Id: <200201161806.g0GI6cE18783@eng4.beaverton.ibm.com>
Subject: raw readv/writev
To: linux-kernel@vger.kernel.org
Date: Wed, 16 Jan 2002 10:06:38 -0800 (PST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two versions of a patch for improving the performance of readv/writev  
for raw io, and I'm not sure which is the better approach.

The current implementation calls read/write for each iovec (unless an override 
routine is defined).  So an 8x32K readv, for example, runs about twice as
slow as a single 256K read.  Both versions of the patch nearly eliminate 
this performance gap.

The first version coalesces the iovecs (up to KIO_MAX_SECTORS bytes of data) 
into a single kiobuf (pre-allocated at file open) and issues 1 call to 
brw_kiovec to submit the io.  The 2nd version of the patch also groups the 
iovecs into a single call to brw_kiovec, but uses one kiobuf per iovec.

Mapping discontiguous virtual memory into a single kiobuf is unconventional,
but minimizes the number of pre-allocated buffer heads (1024 per kiobuf).
It also avoids some of the logistics involved in using one kiobuf for each 
iovec (e.g., when should the kiobufs be allocated/freed and should there
be a system-wide limit on the number of kiobufs in use for this purpose).

Thanks, 
-Janet 
