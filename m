Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTKRA07 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 19:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262196AbTKRA07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 19:26:59 -0500
Received: from holomorphy.com ([199.26.172.102]:32933 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262161AbTKRA05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 19:26:57 -0500
Date: Mon, 17 Nov 2003 16:26:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Joe Korty <joe.korty@ccur.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: format_cpumask()
Message-ID: <20031118002647.GH22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Joe Korty <joe.korty@ccur.com>, "Luck, Tony" <tony.luck@intel.com>,
	linux-kernel@vger.kernel.org
References: <B8E391BBE9FE384DAA4C5C003888BE6F0F37B8@scsmsx401.sc.intel.com> <20031118002213.GA6272@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031118002213.GA6272@tsunami.ccur.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 07:22:13PM -0500, Joe Korty wrote:
> How about this? (eye-checked only).
> static int format_cpumask(char *buf, cpumask_t cpus)
> {
> 	int i, d, len = 0;
> 	cpumask_t tmp;
> 
> 	for(i = (NR_CPUS - 1) & ~3; i >= 0; i -= 4) {
> 		cpus_shift_right(tmp, cpus, i);
> 		d = (int)cpus_coerce(tmp) & 0xf;
> 		buf[len++] = "0123456789abcdef"[d];
> 	}
> 	return len;
> }

I think Keith Owens had a much better suggestion: using '*' in the
format string.


===== include/linux/cpumask.h 1.1 vs edited =====
--- 1.1/include/linux/cpumask.h	Mon Aug 18 19:46:23 2003
+++ edited/include/linux/cpumask.h	Mon Nov 17 16:25:18 2003
@@ -68,4 +68,20 @@
 		cpu < NR_CPUS;						\
 		cpu = next_online_cpu(cpu,map))
 
+static inline int format_cpumask(char *buf, cpumask_t cpus)
+{
+	int k, len = 0;
+
+	for (k = sizeof(cpumask_t)/sizeof(long) - 1; k >= 0; --k) {
+		int m;
+		cpumask_t tmp;
+
+		cpus_shift_right(tmp, cpus, BITS_PER_LONG*k);
+		m = sprintf(buf, "%0*lx", 2*sizeof(long), cpus_coerce(tmp));
+		len += m;
+		buf += m;
+	}
+	return len;
+}
+
 #endif /* __LINUX_CPUMASK_H */
