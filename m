Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVAaRDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVAaRDw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:03:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVAaRDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:03:52 -0500
Received: from waste.org ([216.27.176.166]:59608 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261251AbVAaRDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:03:48 -0500
Date: Mon, 31 Jan 2005 09:03:44 -0800
From: Matt Mackall <mpm@selenic.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/8] lib/sort: turn off self-test
Message-ID: <20050131170344.GP2891@waste.org>
References: <20050131074400.GL2891@waste.org> <20050131035742.1434944c.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050131035742.1434944c.pj@sgi.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2005 at 03:57:42AM -0800, Paul Jackson wrote:
> How about just removing the self test, not "#if 0"'ing it out.
> 
> Better to keep the kernel source code clean of development
> scaffolding.
> 
> Though your patch 1/8 hasn't arrived in my email inbox yet,
> so I don't actually know what 'self test' code it is that
> I am speaking of ;).

It's a nice self-contained unit test. It's here because I ran into a
strange regparm-related bug when developing the code in userspace and
I wanted to be sure that it was easy to diagnose in the field if a
similar bug appeared in the future. I actually think that more code
ought to have such tests, so long as they don't obscure the code in
question.

Here it is for purposes of discussion:

+#if 1
+/* a simple boot-time regression test */
+
+int cmpint(const void *a, const void *b)
+{
+	return *(int *)a - *(int *)b;
+}
+
+static int sort_test(void)
+{
+	int *a, i, r = 0;
+
+	a = kmalloc(1000 * sizeof(int), GFP_KERNEL);
+	BUG_ON(!a);
+
+	printk("testing sort()\n");
+
+	for (i = 0; i < 1000; i++) {
+		r = (r * 725861) % 6599;
+		a[i] = r;
+	}
+
+	sort(a, 1000, sizeof(int), cmpint, 0);
+
+	for (i = 0; i < 999; i++)
+		if (a[i] > a[i+1]) {
+			printk("sort() failed!\n");
+			break;
+		}
+
+	kfree(a);
+
+	return 0;
+}
+
+module_init(sort_test);
+#endif

-- 
Mathematics is the supreme nostalgia of our time.
