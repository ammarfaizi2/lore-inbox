Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbVENAqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbVENAqk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 20:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262646AbVENAq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 20:46:28 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:39887 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262642AbVENAqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 20:46:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:user-agent:content-type:subject:message-id:date;
        b=GvP18OLtQMYDDdOa1RfQWjgy1hs8nGiVIlA1C+TCPrND9n6BQom6C5CooSuElfcmz9DgN8Ublcptb9146u54/6kPz/OGHVFNz50PgoihGee3ra+SPEkcchSNHq8vNrW0FEE24m1QGbtAiKIiVN4ZZfybdgeUzkGlnx0DJQbMtXU=
From: Tejun Heo <htejun@gmail.com>
To: James.Bottomley@steeleye.com
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: lksp 0.3
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH scsi-misc-2.6 00/03] scsi: misc timer fixes (again)
Message-ID: <20050514004601.783910E3@htj.dyndns.org>
Date: Sat, 14 May 2005 09:46:03 +0900 (KST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, James.

 It's been a while, but I'm finally settled with git. :-)

 This is repost of the previous scsi timer patchset.  After thinking
about it a while, the first patch seemed unnecessary as you told, so
it's dropped and the others are regenerated.

 aic79xx_osm.c DV still uses eh_timeout.  Is it gonna be updated like
aic7xxx_osm.c is updated?  If not, I have a patch to fix the eh timer
part.  I have a patcheset waiting for it to be clared - unexporting
SCSI timer as the semantics is very specific and nothing good can come
from tempering with it.  Once aic79xx_osm.c is cleared, I'll post the
patches.

[ Start of patch descriptions ]

01_scsi_timer_dispatch_race_fix.patch
	: remove a timer race in scsi_queue_insert()

	scsi_queue_insert() has four callers.  Three callers call with
	timer disabled and one (the second invocation in
	scsi_dispatch_cmd()) calls with timer activated.
	scsi_queue_insert() used to always call scsi_delete_timer()
	and ignore the return value.  This results in race with timer
	expiration.  Remove scsi_delete_timer() call from
	scsi_queue_insert() and make the caller delete timer and check
	the return value.

02_scsi_timer_remove_delete_timer_from_reset_provider.patch
	: remove unnecessary scsi_delete_timer() call in scsi_reset_provider()

	scsi_reset_provider() calls scsi_delete_timer() on exit which
	isn't necessary.  Remove it.

03_scsi_timer_eh_timer_remove_spurious_if.patch
	: remove spurious if tests from scsi_eh_{times_out|done}

	'if' tests which check if eh_action isn't NULL in both
	functions are always true.  Remove the redundant if's as it
	can give wrong impressions.

[ End of patch descriptions ]

 Thanks.

