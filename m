Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751024AbVIWPJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751024AbVIWPJp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 11:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbVIWPJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 11:09:44 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:36066 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751023AbVIWPJo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 11:09:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=UZciYt0X8whi5f7pz58Wz328FWxb4TqbBDsvj7VFbBcs3Zw0HVElrsm+OSCK0Cd7HsLxWGxCCxbBSTMPaYtGGPp6rdYFjYL1iNpNqeO+1OW1dBSWTu1FZNfYg7bcU5/DzESvJwDgcRUIVJMy+ynisk4Jxb80hMqUhvs30tfdOis=
Date: Fri, 23 Sep 2005 19:20:25 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH -mm v2] Bisecting through -mm with quilt
Message-ID: <20050923152025.GA28868@mipter.zuzino.mipt.ru>
References: <20050923003217.GA18675@mipter.zuzino.mipt.ru> <20050922174250.71f9c6a9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050922174250.71f9c6a9.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 05:42:50PM -0700, Andrew Morton wrote:
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> >  Quick, Dirty, Fragile, Should Work (TM).
> 
> hm, I wouldn't use it.  The problem is that a _lot_ of patches in -mm don't
> fscking compile.
> 
> 	bix:/usr/src/25> grep '[-]fix.patch' series | wc
> 	     72      72    2905
> 
> If your bisection happens to land you between foo.patch and foo-fix.patch,
> you have a *known bad* kernel.   What's the point in testing it?
> 
> So I'd recommend the smarter approach: copy the series file to ~/hunt, edit
> ~/hunt and do the bisection by hand, marking the good and bad points in
> ~/hunt as you go.

Done. If this isn't what you want, tell me so.
-----------------------------------------------------------------------
Marking patches as good or bad is separated from applying/reverting.
You can edit "series-bisect-mm" manually, then do "./bisect-mm apply"
and it will change tree to the new middle point.

Manual editing boils down to:
			    .--> "good fix-typo.patch"
	"fix-typo.patch" --<
			    `--> "bad fix-typo.patch"

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 bisect-mm |  108 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

--- a/bisect-mm
+++ b/bisect-mm
@@ -0,0 +1,108 @@
+#!/bin/sh
+#
+# Bisecting through -mm with quilt.
+#
+# Assumptions:
+#	* X + linus.patch works
+#	* X-mmY doesn't
+#	* broken-out -mmY is in $QUILT_PATCHES
+#
+# Usage:
+#	./bisect-mm start	mark linus.patch as good, last patch as bad
+#		|
+# +------>------+
+# |		|
+# |	[manually edit series-bisect-mm:		]
+# |	[mark known good patches as "good $GOOD.patch"	]
+# ^	[mark known bad patches as "bad $BAD.patch"	]
+# |		|
+# |	./bisect-mm apply	quilt will apply/revert stuff
+# |		|
+# +------<------+
+# |		|
+# |	     rebuild
+# |	      retest
+# ^		|
+# |	./bisect-mm {bad,good}
+# |		|
+# |		|
+# +------<------+---->	Sucker is fix-typo.patch
+
+usage()
+{
+	echo "usage: bisect-mm [start | good | bad | apply]" >&2
+	exit 1
+}
+
+SERIES=series-bisect-mm
+
+apply()
+{
+	quilt push -q | sed -e "s/^Applying patch/+/" -e "/^Now at patch/d"
+}
+
+revert()
+{
+	quilt pop -q | sed -e "s/^Removing patch/-/" -e "/^Now at patch/d"
+}
+
+case "$#" in
+0)
+	usage
+	;;
+*)
+	case "$1" in
+	start)
+		echo -n "good " >$SERIES
+		quilt series >>$SERIES
+		sed -i "s/$(tail -n1 $SERIES)/bad &/" $SERIES
+		echo "+ $SERIES"
+		;;
+	bad)
+		TOP=$(quilt top)
+		sed -i "s/.*$TOP/bad $TOP/" $SERIES
+		GOOD=$(cat -n $SERIES | grep "good " | tail -n1 | awk '{print $1}')
+		BAD=$(cat -n $SERIES | grep "bad " | head -n1 | awk '{print $1}')
+		if [ $(($BAD - $GOOD)) = 1 ]; then
+			echo -n "Sucker is "
+			quilt top
+			exit 0
+		fi
+		;;
+	good)
+		TOP=$(quilt top)
+		sed -i "s/.*$TOP/good $TOP/" $SERIES
+		GOOD=$(cat -n $SERIES | grep "good " | tail -n1 | awk '{print $1}')
+		BAD=$(cat -n $SERIES | grep "bad " | head -n1 | awk '{print $1}')
+		if [ $(($BAD - $GOOD)) = 1 ]; then
+			apply
+			echo -n "Sucker is "
+			quilt top
+			exit 0
+		fi
+		;;
+	apply)
+		GOOD=$(cat -n $SERIES | grep "good " | tail -n1 | awk '{print $1}')
+		BAD=$(cat -n $SERIES | grep "bad " | head -n1 | awk '{print $1}')
+		MIDDLE=$((($GOOD + $BAD) / 2))
+		TOP=$(quilt top)
+		CUR=$(quilt applied | wc -l)
+
+		if [ $MIDDLE -lt $CUR ]; then
+			while [ $MIDDLE -lt $(quilt applied | wc -l) ]; do
+				revert
+			done
+			quilt top
+		else
+			while [ $MIDDLE -gt $(quilt applied | wc -l) ]; do
+				apply
+			done
+		fi
+		echo "[$GOOD .. => $MIDDLE <= .. $BAD]"
+		;;
+	*)
+		usage
+		;;
+	esac
+	;;
+esac

