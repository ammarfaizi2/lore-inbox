Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265489AbUHRXCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265489AbUHRXCZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 19:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266306AbUHRXCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 19:02:25 -0400
Received: from mailfe04.swip.net ([212.247.154.97]:16520 "EHLO
	mailfe04.swip.net") by vger.kernel.org with ESMTP id S265489AbUHRXCO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 19:02:14 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
Date: Thu, 19 Aug 2004 01:02:11 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: [samuel.thibault@ens-lyon.org: Re: warning: comparison is always false due to limited range of  data type]
Message-ID: <20040818230211.GG22559@bouh.is-a-geek.org>
Mail-Followup-To: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i-nntp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le lun 09 aoû 2004 à 04:50:04 +0200, Paul Jackson a tapoté sur son clavier :
> Unfortunately, this patch uses the notorious "gcc warning suppression
> by obfuscation" technique.
> 
> --- 2.6.8-rc2-mm2.orig/include/linux/highuid.h	2004-08-04 19:27:48.000000000 -0700
> +++ 2.6.8-rc2-mm2/include/linux/highuid.h	2004-08-08 19:03:47.000000000 -0700
> @@ -44,8 +44,8 @@ extern void __bad_gid(void);
>  #ifdef CONFIG_UID16
>  
>  /* prevent uid mod 65536 effect by returning a default value for high UIDs */
> -#define high2lowuid(uid) ((uid) > 65535 ? (old_uid_t)overflowuid : (old_uid_t)(uid))
> -#define high2lowgid(gid) ((gid) > 65535 ? (old_gid_t)overflowgid : (old_gid_t)(gid))
> +#define high2lowuid(uid) ((uid) & ~0xFFFF ? (old_uid_t)overflowuid : (old_uid_t)(uid))
> +#define high2lowgid(gid) ((gid) & ~0xFFFF ? (old_gid_t)overflowgid : (old_gid_t)(gid))
>  /*
> ...

Here is another approach. This should never warning, and should get
optimized away as needed.

Regards,
Samuel

--- linux-2.6.8.1-orig/include/linux/highuid.h	2003-10-08 22:20:06.000000000 +0200
+++ linux-2.6.8.1-perso/include/linux/highuid.h	2004-08-19 00:47:31.000000000 +0200
@@ -44,8 +44,8 @@
 #ifdef CONFIG_UID16
 
 /* prevent uid mod 65536 effect by returning a default value for high UIDs */
-#define high2lowuid(uid) ((uid) > 65535 ? (old_uid_t)overflowuid : (old_uid_t)(uid))
-#define high2lowgid(gid) ((gid) > 65535 ? (old_gid_t)overflowgid : (old_gid_t)(gid))
+#define high2lowuid(uid) ((sizeof(uid) > 2 ? (uid) : 0) > 65535 ? (old_uid_t)overflowuid : (old_uid_t)(uid))
+#define high2lowgid(gid) ((sizeof(gid) > 2 ? (gid) : 0) > 65535 ? (old_gid_t)overflowgid : (old_gid_t)(gid))
 /*
  * -1 is different in 16 bits than it is in 32 bits
  * these macros are used by chown(), setreuid(), ...,
@@ -89,8 +89,8 @@
  * Since these macros are used in architectures that only need limited
  * 16-bit UID back compatibility, we won't use old_uid_t and old_gid_t
  */
-#define fs_high2lowuid(uid) ((uid) > 65535 ? (uid16_t)fs_overflowuid : (uid16_t)(uid))
-#define fs_high2lowgid(gid) ((gid) > 65535 ? (gid16_t)fs_overflowgid : (gid16_t)(gid))
+#define fs_high2lowuid(uid) ((sizeof(uid) > 2 ? (uid) : 0) > 65535 ? (uid16_t)fs_overflowuid : (uid16_t)(uid))
+#define fs_high2lowgid(gid) ((sizeof(gid) > 2 ? (gid) : 0) > 65535 ? (gid16_t)fs_overflowgid : (gid16_t)(gid))
 
 #define low_16_bits(x)	((x) & 0xFFFF)
 #define high_16_bits(x)	(((x) & 0xFFFF0000) >> 16)

