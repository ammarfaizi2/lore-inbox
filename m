Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312381AbSDSKqO>; Fri, 19 Apr 2002 06:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312364AbSDSKqN>; Fri, 19 Apr 2002 06:46:13 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:28421 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S312484AbSDSKqM>; Fri, 19 Apr 2002 06:46:12 -0400
Message-Id: <200204191042.g3JAgbX04232@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andrew Morton <akpm@zip.com.au>, Mark Peloquin <peloquin@us.ibm.com>
Subject: Re: Bio pool & scsi scatter gather pool usage
Date: Fri, 19 Apr 2002 13:44:53 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OFA8584441.22F71259-ON85256B9F.00627FAA@pok.ibm.com> <3CBF1722.EDA8631F@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 April 2002 16:57, Andrew Morton wrote:
> > This would require the BIO assembly code to make at least one
> > call to find the current permissible BIO size at offset xyzzy.
> > Depending on the actual IO size many foo_max_bytes calls may
> > be required. Envision the LVM or RAID case where physical
> > extents or chunks sizes can be as small as 8Kb I believe. For
> > a 64Kb IO, its conceivable that 9 calls to foo_max_bytes may
> > be required to package that IO into permissibly sized BIOs.

[snip]

> The good way is:
>
> 	int maxbytes[something];
> 	int i = 0;
>
> 	while (more_to_send) {
> 		maxbytes[i] = bio_max_bytes(block);
> 		block += maxbytes[i++] / whatever;
> 	}
> 	i = 0;
> 	while (more_to_send) {
> 		build_and_send_a_bio(block, maxbytes[i]);
> 		block += maxbytes[i++] / whatever;
> 	}
>
> if you get my drift.  This way the computational costs of
> the second and succeeding bio_max_bytes() calls are very
> small.

This has the advantage of being simple too.

> One thing which concerns me about the whole scheme at
> present is that the uncommon case (volume managers, RAID,
> etc) will end up penalising the common case - boring
> old ext2 on boring old IDE/SCSI.

Yes but since performance gap between CPU and devices
continue to increase simplicity outweights
CPU cycles wastage here. We are going to wait much longer
for IO to take place anyway.

> Right now, BIO_MAX_SECTORS is only 64k, and IDE can
> take twice that.  I'm not sure what the largest
> request size is for SCSI - certainly 128k.

Yep, submitting largest possible block in one go is a win.
--
vda
