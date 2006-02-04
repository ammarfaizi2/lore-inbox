Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751532AbWBDN2p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbWBDN2p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 08:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWBDN2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 08:28:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38083 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751493AbWBDN2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 08:28:44 -0500
Date: Sat, 4 Feb 2006 13:28:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>, Zach Brown <zach.brown@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/3] Vectorize aio_read/aio_write methods
Message-ID: <20060204132838.GA29549@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Zach Brown <zach.brown@oracle.com>,
	lkml <linux-kernel@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <1138896758.28382.112.camel@dyn9047017102.beaverton.ibm.com> <1138896879.28382.114.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138896879.28382.114.camel@dyn9047017102.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 	do {
-		ret = file->f_op->aio_read(iocb, iocb->ki_buf,
-			iocb->ki_left, iocb->ki_pos);
+		struct iovec iov = {
+			.iov_base = iocb->ki_buf,
+			.iov_len = iocb->ki_left
+		};
+
+		ret = file->f_op->aio_read(iocb, &iov, 1, iocb->ki_pos);

this still has the lifetime problems Ben pointed out.  aio might still
be outstanding when this thread returned to userspace, so we need to
dynamically allocated the iovec and free it later.  (or make it part
of the iocb?)

