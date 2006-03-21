Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932456AbWCUV2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932456AbWCUV2N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 16:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbWCUV2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 16:28:13 -0500
Received: from mail.parknet.jp ([210.171.160.80]:46341 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S932456AbWCUV2M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 16:28:12 -0500
X-AuthUser: hirofumi@parknet.jp
To: linux-kernel@vger.kernel.org
Subject: PM-Timer Bug test program
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 22 Mar 2006 06:28:07 +0900
Message-ID: <871wwvxzbs.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=


  # dmesg | grep PM
  ACPI: PM-Timer IO Port: 0x808
  # ./pmtmr_test 0x808                  # run as root


  ./pmtmr_test: Detect PM-Timer Bug

If it detected a bug, it will show the above message.

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>


--=-=-=
Content-Type: text/x-csrc
Content-Disposition: inline; filename=pmtmr_test.c

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <error.h>
#include <sys/io.h>

typedef unsigned int	u32;
static unsigned short pmtmr_ioport;
static int cnt;

#define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */

static u32 read_pmtmr(void)
{
	u32 v1=0,v2=0,v3=0;
	/* It has been reported that because of various broken
	 * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM time
	 * source is not latched, so you must read it multiple
	 * times to insure a safe value is read.
	 */
	cnt = 0;
	do {
		v1 = inl(pmtmr_ioport);
		v2 = inl(pmtmr_ioport);
		v3 = inl(pmtmr_ioport);
		cnt++;
	} while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
			|| (v3 > v1 && v3 < v2));

	/* mask the output to 24 bits */
	return v2 & ACPI_PM_MASK;
}

int main(int argc, char *argv[])
{
	int i;

	if (argc < 2)
		error(1, 0, "Usage: %s pmtmr_port\n", argv[0]);

	pmtmr_ioport = strtoul(argv[1], NULL, 0);
	if ((pmtmr_ioport & 0xff) != 0x08)
		error(1, 0, "Invalid port address: 0x%x\n", pmtmr_ioport);

	if (iopl(3) < 0)
		error(1, errno, "iopl");

	for (i = 0; i < 10000000; i++) {
		read_pmtmr();
		if (cnt > 1)
			error(1, 0, "Detect PM-Timer Bug\n");
		if ((i % 100000) == 0)
			printf("%d\n", i);
	}
	return 0;
}

--=-=-=--
