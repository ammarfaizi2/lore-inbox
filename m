Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbVIWAVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbVIWAVo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 20:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbVIWAVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 20:21:44 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:20135 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751222AbVIWAVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 20:21:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=eMyhJDo1pxkF/XNKnirtZoqE1/pFRBZIH1J37B+UWdMgle4/8x36+Xurm5pQc69uMB8wFx54UWNw3v+WnZEK+QZk+Y6qGaHViqjFAfEV5l+WqrEV/L4L08lPMFtzJ8Qk2u6Czbtimrt4CgX0fQBY+AkiI9WIEzxOOppSureRlqM=
Date: Fri, 23 Sep 2005 04:32:17 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] Bisecting through -mm with quilt
Message-ID: <20050923003217.GA18675@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quick, Dirty, Fragile, Should Work (TM).

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 mm-bisect |   83 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff -uprN linux-vanilla/mm-bisect linux-mm-bisect/mm-bisect
--- linux-vanilla/mm-bisect	1970-01-01 03:00:00.000000000 +0300
+++ linux-mm-bisect/mm-bisect	2005-09-23 04:25:26.000000000 +0400
@@ -0,0 +1,82 @@
+#!/bin/sh
+#
+# Bisecting through -mm.
+#
+# Assumptions
+# -----------
+# 1) X works
+# 2) X-mmY doesn't
+# 3) -mmY in broken-out form is in $QUILT_PATCHES, "quilt push -a"'d
+#
+# Usage cycle
+# -----------
+#	mm-bisect start
+#		...			<=== applying/reverting patches
+#	[recompile]
+#	[retest]
+# 	mm-bisect good			<=== if it works
+#		...
+#	[recompile]
+#	[retest]
+#	mm-bisect bad			<=== if it doesn't
+#		[...]
+#	Sucker is fix-typo.patch	<=== who to blame
+
+usage()
+{
+	echo >&2 'usage: mm-bisect [start | good | bad]'
+	exit 1
+}
+
+case "$#" in
+0)
+	usage
+	;;
+*)
+	CUR=$(quilt applied | wc -l)
+	case "$1" in
+	start)
+		echo 0 >.mm-bisect-good
+		echo $CUR >.mm-bisect-bad
+		;;
+	good)
+		if [ $(($(cat .mm-bisect-bad) - $CUR)) = 1 ]; then
+			quilt push -q >/dev/null
+			echo -n "Sucker is "
+			quilt top
+			rm -f .mm-bisect-bad .mm-bisect-good
+			exit 0
+		fi
+		echo $CUR >.mm-bisect-good
+		;;
+	bad)
+		if [ $(($CUR - $(cat .mm-bisect-good))) = 1 ]; then
+			echo -n "Sucker is "
+			quilt top
+			rm -f .mm-bisect-bad .mm-bisect-good
+			exit 0
+		fi
+		echo $CUR >.mm-bisect-bad
+		;;
+	*)
+		usage
+		;;
+	esac
+	GOOD=$(cat .mm-bisect-good)
+	BAD=$(cat .mm-bisect-bad)
+	MIDDLE=$((($BAD + $GOOD) / 2))
+	echo "[$GOOD .. $BAD] => $MIDDLE"
+	if [ $MIDDLE -lt $CUR ]; then
+		while [ $MIDDLE -lt $(quilt applied | wc -l) ]; do
+			quilt pop -q | sed -e "s/^Removing patch/-/" \
+						-e "/^Now at patch /d"
+		done
+	else
+		while [ $MIDDLE -gt $(quilt applied | wc -l) ]; do
+			quilt push -q | sed -e "s/^Applying patch/+/" \
+						-e "/^Now at patch /d"
+		done
+	fi
+	quilt top
+	echo "[$GOOD .. => $MIDDLE <= .. $BAD]"
+esac

