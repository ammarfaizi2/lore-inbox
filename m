Return-Path: <SRS0=KKPr=ZF=vger.kernel.org=io-uring-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E80C43331
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 00:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD4352084E
	for <io-uring@archiver.kernel.org>; Wed, 13 Nov 2019 00:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PG7hGf1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfKMAEa (ORCPT <rfc822;io-uring@archiver.kernel.org>);
        Tue, 12 Nov 2019 19:04:30 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22125 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726912AbfKMAEa (ORCPT
        <rfc822;io-uring@vger.kernel.org>); Tue, 12 Nov 2019 19:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573603469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NfgXQMRx6S/qylDTW64CbcDU4x052JeHjpyOa6N9OPI=;
        b=PG7hGf1mzIn+jPezWN61osD/idLhdkuHF516cvm41bg0YBzKyt58ME+LddhFQXD+/kNDpV
        dRF0IMjxPtFMlBat5ofyiv2xOQGrwsWbCCWRK40jAiEi+gVfJDzSNFkoM+NNKzDlTlMQq1
        JGHLiS8ng4nDBgVeFlGFbILPLmd6WP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-AFQQbD8ZORS8g0qwNYJL6g-1; Tue, 12 Nov 2019 19:04:27 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EADF61800D7A;
        Wed, 13 Nov 2019 00:04:26 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D31560251;
        Wed, 13 Nov 2019 00:04:26 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     io-uring@vger.kernel.org
Cc:     axboe@kernel.dk
Subject: [liburing patch][v2] test: fix up dead code bugs
References: <x49eeycirmq.fsf@segfault.boston.devel.redhat.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Tue, 12 Nov 2019 19:04:25 -0500
In-Reply-To: <x49eeycirmq.fsf@segfault.boston.devel.redhat.com> (Jeff Moyer's
        message of "Tue, 12 Nov 2019 18:47:41 -0500")
Message-ID: <x495zjoiquu.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: AFQQbD8ZORS8g0qwNYJL6g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: io-uring-owner@vger.kernel.org
Precedence: bulk
List-ID: <io-uring.vger.kernel.org>
X-Mailing-List: io-uring@vger.kernel.org

Coverity pointed out some dead code.  Fix it.

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

---
v2: Don't re-introduce dead-code! (Jens Axboe)

diff --git a/test/fsync.c b/test/fsync.c
index e6e0898..1a1890e 100644
--- a/test/fsync.c
+++ b/test/fsync.c
@@ -96,14 +96,14 @@ static int test_barrier_fsync(struct io_uring *ring)
 =09io_uring_sqe_set_flags(sqe, IOSQE_IO_DRAIN);
=20
 =09ret =3D io_uring_submit(ring);
-=09if (ret < 5) {
-=09=09printf("Submitted only %d\n", ret);
-=09=09goto err;
-=09} else if (ret < 0) {
+=09if (ret < 0) {
 =09=09printf("sqe submit failed\n");
 =09=09if (ret =3D=3D EINVAL)
 =09=09=09printf("kernel may not support barrier fsync yet\n");
 =09=09goto err;
+=09} else if (ret < 5) {
+=09=09printf("Submitted only %d\n", ret);
+=09=09goto err;
 =09}
=20
 =09for (i =3D 0; i < 5; i++) {
diff --git a/test/nop.c b/test/nop.c
index 1373695..4b072fc 100644
--- a/test/nop.c
+++ b/test/nop.c
@@ -62,12 +62,12 @@ static int test_barrier_nop(struct io_uring *ring)
 =09}
=20
 =09ret =3D io_uring_submit(ring);
-=09if (ret < 8) {
-=09=09printf("Submitted only %d\n", ret);
-=09=09goto err;
-=09} else if (ret < 0) {
+=09if (ret < 0) {
 =09=09printf("sqe submit failed: %d\n", ret);
 =09=09goto err;
+=09} else if (ret < 8) {
+=09=09printf("Submitted only %d\n", ret);
+=09=09goto err;
 =09}
=20
 =09for (i =3D 0; i < 8; i++) {
diff --git a/test/stdout.c b/test/stdout.c
index 7b64c8c..b12d75c 100644
--- a/test/stdout.c
+++ b/test/stdout.c
@@ -28,12 +28,12 @@ static int test_pipe_io(struct io_uring *ring)
 =09io_uring_prep_writev(sqe, STDOUT_FILENO, &vecs, 1, 0);
=20
 =09ret =3D io_uring_submit(ring);
-=09if (ret < 1) {
-=09=09printf("Submitted only %d\n", ret);
-=09=09goto err;
-=09} else if (ret < 0) {
+=09if (ret < 0) {
 =09=09printf("sqe submit failed: %d\n", ret);
 =09=09goto err;
+=09} else if (ret < 1) {
+=09=09printf("Submitted only %d\n", ret);
+=09=09goto err;
 =09}
=20
 =09ret =3D io_uring_wait_cqe(ring, &cqe);

