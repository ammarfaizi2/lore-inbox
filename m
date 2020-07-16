Return-Path: <SRS0=Z6pD=A3=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3B6C433EA
	for <io-uring@archiver.kernel.org>; Thu, 16 Jul 2020 12:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E4620739
	for <io-uring@archiver.kernel.org>; Thu, 16 Jul 2020 12:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQ/3XGOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgGPMtP (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Thu, 16 Jul 2020 08:49:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59627 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728232AbgGPMtB (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Thu, 16 Jul 2020 08:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594903740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=uaIPW54kqULYezLBNEp1wzYUF/CfEEz3Uiiha/ZVVF4=;
        b=MQ/3XGOSd5Q5YrHzpA31NXVTyCasfN6zPRq9mYgPsooAi1y4LZDIq/9XnT2FXThsbGbr8T
        wi/QiBdFih09QVxqeWZjFcGvy1f/Iokb5Dg1Kz1EXokU0fynKzgM7v1ozIlElV7Tun3ROQ
        Ah7gKeb2iQNmy2z0+tKY7guIZIgGT1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-TG6ruVBSN5WSYIjOFApk0w-1; Thu, 16 Jul 2020 08:48:50 -0400
X-MC-Unique: TG6ruVBSN5WSYIjOFApk0w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D41B100CCC4;
        Thu, 16 Jul 2020 12:48:48 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-107.ams2.redhat.com [10.36.114.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9146B78A58;
        Thu, 16 Jul 2020 12:48:36 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <asarai@suse.de>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC v2 0/3] io_uring: add restrictions to support untrusted
 applications and guests
Date:   Thu, 16 Jul 2020 14:48:30 +0200
Message-Id: <20200716124833.93667-1-sgarzare@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

I fixed some issues that Jens pointed out, and also the TODOs that I left
in the previous version.

I still have any doubts about patch 3, any advice?

RFC v1 -> RFC v2:
    - added 'restricted' flag in the ctx [Jens]
    - added IORING_MAX_RESTRICTIONS define
    - returned EBUSY instead of EINVAL when restrictions are already
      registered
    - reset restrictions if an error happened during the registration
    - removed return value of io_sq_offload_start()

RFC v1: https://lore.kernel.org/io-uring/20200710141945.129329-1-sgarzare@redhat.com

Following the proposal that I send about restrictions [1], I wrote this series
to add restrictions in io_uring.

I also wrote helpers in liburing and a test case (test/register-restrictions.c)
available in this repository:
https://github.com/stefano-garzarella/liburing (branch: io_uring_restrictions)

Just to recap the proposal, the idea is to add some restrictions to the
operations (sqe, register, fixed file) to safely allow untrusted applications
or guests to use io_uring queues.

The first patch changes io_uring_register(2) opcodes into an enumeration to
keep track of the last opcode available.

The second patch adds IOURING_REGISTER_RESTRICTIONS opcode and the code to
handle restrictions.

The third patch adds IORING_SETUP_R_DISABLED flag to start the rings disabled,
allowing the user to register restrictions, buffers, files, before to start
processing SQEs.
I'm not sure if this could help seccomp. An alternative pointed out by Jann
Horn could be to register restrictions during io_uring_setup(2), but this
requires some intrusive changes (there is no space in the struct
io_uring_params to pass a pointer to restriction arrays, maybe we can add a
flag and add the pointer at the end of the struct io_uring_params).

Another limitation now is that I need to enable every time
IORING_REGISTER_ENABLE_RINGS in the restrictions to be able to start the rings,
I'm not sure if we should treat it as an exception.

Maybe registering restrictions during io_uring_setup(2) could solve both issues
(seccomp integration and IORING_REGISTER_ENABLE_RINGS registration), but I need
some suggestions to properly extend the io_uring_setup(2).

Comments and suggestions are very welcome.

Thank you in advance,
Stefano

[1] https://lore.kernel.org/io-uring/20200609142406.upuwpfmgqjeji4lc@steredhat/

Stefano Garzarella (3):
  io_uring: use an enumeration for io_uring_register(2) opcodes
  io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
  io_uring: allow disabling rings during the creation

 fs/io_uring.c                 | 152 ++++++++++++++++++++++++++++++++--
 include/uapi/linux/io_uring.h |  56 ++++++++++---
 2 files changed, 188 insertions(+), 20 deletions(-)

-- 
2.26.2

