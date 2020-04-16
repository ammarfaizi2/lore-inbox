Return-Path: <SRS0=kSh0=6A=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F667C38A29
	for <io-uring@archiver.kernel.org>; Thu, 16 Apr 2020 05:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03FF820784
	for <io-uring@archiver.kernel.org>; Thu, 16 Apr 2020 05:32:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XUW+Db+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406444AbgDPFcQ (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 16 Apr 2020 01:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406188AbgDPFcM (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 16 Apr 2020 01:32:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122A4C061A0F;
        Wed, 15 Apr 2020 22:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=caaBFvJdfOo1IN5qevwlJmwf935Igyt+4EcpOBF44yE=; b=XUW+Db+sJFJbLBoT8O5Wa0upCM
        /aJd+zWh0noLirqF3SVMiXpymnjLe2pbURetrVTa/cBAFmv0kU/9CkjyOkMUX6ItRycFtWBPd8WNB
        y43uek6dwdJWBJZQWlqcKldVjOchgwPo55LyImUsSYL2T5MY2hP5YyyRLFJE16gH9x3dlp2saYoiG
        8hz2Bv7hq6CvtCqux1v32NoCaZZytQny8Tq3TY5gDJecVHXo4f5h6Dy9XuhU4MCEP7fPUMAEOcBdA
        vbvIfpCbshY9cVHo5xPgTl2uM6SAwiLbSF948nCXBCVfurje9wpH4LMz5EbRV2hW7mspgF17vb1C1
        srKZ6lNg==;
Received: from [2001:4bb8:184:4aa1:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOx84-0003cw-Kn; Thu, 16 Apr 2020 05:32:01 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-usb@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        linux-mm@kvack.org
Subject: improve use_mm / unuse_mm v2
Date:   Thu, 16 Apr 2020 07:31:55 +0200
Message-Id: <20200416053158.586887-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Hi all,

this series improves the use_mm / unuse_mm interface by better
documenting the assumptions, and my taking the set_fs manipulations
spread over the callers into the core API.

Changes since v1:
 - drop a few patches
 - fix a comment typo
 - cover the newly merged use_mm/unuse_mm caller in vfio
