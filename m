Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVAGXnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVAGXnH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 18:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261739AbVAGXlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 18:41:40 -0500
Received: from cliff.niehs.nih.gov ([157.98.192.45]:25488 "EHLO
	cliff.niehs.nih.gov") by vger.kernel.org with ESMTP id S261737AbVAGXjE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 18:39:04 -0500
Message-ID: <41DF1D96.6030109@niehs.nih.gov>
Date: Fri, 07 Jan 2005 18:39:02 -0500
From: Joe Krahn <krahn@niehs.nih.gov>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Bogus REPORT_LUNS responses breaks SCSI LUN detection
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are apparently several devices that return bad data
for the REPORT_LUNS query, but do not return an error.
The newer kernels only do sequential LUN scans if REPORT_LUNS
fails. There may need to be a kernel option to force sequential
scans.

It might be useful to always do sequential scans, and
only rely on REPORT_LUNS to correctly setup non-sequential LUNs,
where it should be working correctly. Or, at least try sequential
scans if the REPORT_LUNS reply looks 'suspicious'.

Here are some related reports of problems. All of these are RAID
systems, so it may be a specific embedded controller at fault,
but you can't tell this by looking at the Vendor/Model fields.

SuSE 9.1
Vendor: easyRAID Model: X16 Rev: 0001
Type: Direct-Access ANSI SCSI revision: 03
scsi: host 0 channel 0 id 5 lun 0x6500737952414944 has a LUN larger than 
currently supported.

SuSE 9.1
Vendor: FX-1600U Model: 3-R Rev: 0001
Type: Direct-Access ANSI SCSI revision: 03
scsi: host 3 channel 0 id 0 lun 0x00000200080c0400 has a LUN larger than 
currently supported.

Kernel 2.6, unknown distro
Vendor: transtec  Model:                   Rev: 0001
Type:   Direct-Access                      ANSI SCSI revision: 03
On host 1 channel 0 id 1 only 128 (max_scsi_report_luns) of 536870896 
luns reported, try increasing max_scsi_report_luns.
scsi: host 1 channel 0 id 1 lun 0x7400616e73746563 has a LUN larger than 
currently supported.

Fedora Core 2 and 3
Vendor: Tornado-  Model: F4                Rev: 0001
Type:   Direct-Access                      ANSI SCSI revision: 03
scsi: host 1 channel 0 id 8 lun 0x00000200080c0400 has a LUN larger than 
currently supported.


I noticed that these LUN hex values decode to text fragments:
Easy RAID decodes to: 'e.syRAID'
Vendor=Transtec, lun decodes to 't.anstec'.

And, here is a raw dump the REPORT_LUNS response from Tornado F4:
0000000: 00 00 00 80 8b 00 01 32  .......2
0000008: 54 00 72 6e 61 64 6f 2d  T.rnado-
0000010: 46 01 20 20 20 20 20 20  F.
0000018: 20 02 20 20 20 20 20 20   .
0000020: 30 03 30 31 00 00 00 00  0.01....
...

