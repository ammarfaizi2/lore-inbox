Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261609AbVCWOV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261609AbVCWOV2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 09:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261612AbVCWOV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 09:21:28 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:63492 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261609AbVCWOVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 09:21:13 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: swapped memset arguments.
Date: Wed, 23 Mar 2005 16:20:48 +0200
User-Agent: KMail/1.5.4
References: <20050322024457.GA11569@redhat.com>
In-Reply-To: <20050322024457.GA11569@redhat.com>
Cc: linux-kernel@vger.kernel.org, vital@ilport.com.ua
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_AtXQCaGDm1IgaIn"
Message-Id: <200503231620.48845.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_AtXQCaGDm1IgaIn
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 22 March 2005 04:44, Dave Jones wrote:
> You wouldn't believe how many instances of this bug I've
> seen in the last few days in both userspace and kernelspace.
> 
> -		memset(&target_route->rcu, sizeof(struct rcu_head), 0);
> +		memset(&target_route->rcu, 0, sizeof(struct rcu_head));

Hehe.

# grep -r 'memset.*,[ 0x]*)' .
./sound/oss/cmpci.c:            memset(buf + bptr, c, x);
./sound/oss/cmpci.c:                    memset(buf1 + bptr, c, x);
./sound/oss/swarm_cs4297a.c:            memset(((char *) buf) + bptr, c, x);
./sound/oss/esssolo1.c:         memset(((char *)buf) + bptr, c, x);
./sound/oss/es1370.c:           memset(((char *)buf) + bptr, c, x);
./sound/oss/es1371.c:           memset(((char *)buf) + bptr, c, x);
./sound/oss/maestro.c:          memset(buf + bptr, c, x);
./sound/oss/cs4281/cs4281m.c:           memset(((char *) buf) + bptr, c, x);
./sound/oss/maestro3.c:        memset(buf + bptr, c, x);
./sound/oss/sonicvibes.c:               memset(buf + bptr, c, x);
./sound/oss/ali5455.c:          memset(dmabuf->rawbuf + swptr, '\0', x);
./drivers/char/hvcs.c: * 1.3.0 -> 1.3.1 In hvcs_open memset(..,0x00,..) instead of memset(..,0x3F,00).
./drivers/s390/scsi/zfcp_aux.c: memset(sg_list->sg, sg_list->count * sizeof(struct scatterlist), 0);
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
./Documentation/scsi/ChangeLog.1992-1997:       * scsi.c (scan_scsis): memset(SDpnt, 0) and set SCmd.device to SDpnt.
./include/asm-frv/uaccess.h:#define clear_user(dst,count)                       (memset((dst), 0, (count)), 0)

Patch attached.
--
vda

--Boundary-00=_AtXQCaGDm1IgaIn
Content-Type: text/x-diff;
  charset="koi8-r";
  name="zfcp_aux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="zfcp_aux.patch"

--- linux-2.6.11.src/drivers/s390/scsi/zfcp_aux.c.orig	Thu Feb  3 11:39:40 2005
+++ linux-2.6.11.src/drivers/s390/scsi/zfcp_aux.c	Wed Mar 23 16:16:45 2005
@@ -583,7 +583,7 @@ zfcp_sg_list_alloc(struct zfcp_sg_list *
 		retval = -ENOMEM;
 		goto out;
 	}
-	memset(sg_list->sg, sg_list->count * sizeof(struct scatterlist), 0);
+	memset(sg_list->sg, 0, sg_list->count * sizeof(struct scatterlist));
 
 	for (i = 0, sg = sg_list->sg; i < sg_list->count; i++, sg++) {
 		sg->length = min(size, PAGE_SIZE);

--Boundary-00=_AtXQCaGDm1IgaIn--

