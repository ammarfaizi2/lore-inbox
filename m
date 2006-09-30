Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWI3Ax0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWI3Ax0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 20:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWI3Ax0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 20:53:26 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:57247 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932405AbWI3AxZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 20:53:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=LMOYcEkpTXrbWJrocEZyA0LUTRjjYPGJHYqmfI1Qs0LXWnSGcpqKGT//tTjPHGCtxTYXD8JVR9WGgAn3fKBNTHa0m+NeZRAF5XapS3LKxGhW/w65d2P+ovCcUNvwxdZ/eJlblitA+gFsn9EM/cbqLp3AMgl/Vsm8e02lQa29Nxs=
Message-ID: <a2ebde260609291753u58dc2c42p142aa7b661f918e5@mail.gmail.com>
Date: Sat, 30 Sep 2006 08:53:24 +0800
From: "Dong Feng" <middle.fengdong@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Race Condition over sys_tz
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The operations on sys_tz, so far known to me in sys_settimeofday and
sys_gettimeofday, is neither atomic nor protected by any lock. I
suspect it probably causes unpredictable behavior when multiple
processes try to set the system time zone simultaneously.

Following is the code fragment extracted from do_sys_settimeofday().
The function is invoked by sys_settimeofday() without locking. At
least two non-atomic operations:

1. struct copy between *tz and sys_tz.
2. The test-and-operate over firsttime.

if (tz) {
        /* SMP safe, global irq locking makes it work. */
        sys_tz = *tz;
        if (firsttime) {
                firsttime = 0;
                if (!tv)
                        warp_clock();
        }
}
