Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932475AbVIZSvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475AbVIZSvv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 14:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVIZSvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 14:51:51 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:34274 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932478AbVIZSvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 14:51:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=koCo+7gmXURi3Gsez0cXu7eUCmEFwH/cNA7Ej3KoBcDLat8hi99EYyt6aRP/AGkeNFCoYpmiX4nhZfk5SJJie7/4jwm5EkqNGKVsEd2jH5vZvs8Rp6ciK1OtAUE+HE4fkdzJC9NfdGC6TBYg2vrv7SerpkDDrOjBqkAKza8pASo=
Date: Mon, 26 Sep 2005 23:02:40 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.14-rc2-mm1 ide problems on AMD64
Message-ID: <20050926190240.GA32409@mipter.zuzino.mipt.ru>
References: <1127758020.16275.19.camel@dyn9047017102.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <1127758020.16275.19.camel@dyn9047017102.beaverton.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 26, 2005 at 11:07:00AM -0700, Badari Pulavarty wrote:
> 2.6.14-rc2-mm1 doesn't seem to boot on my AMD64 box. It hangs
> while probing "ide" disks. I spent time looking at it and
> here is what I know so far.
> 
> 	2.6.13: works fine
> 	2.6.13-mm series: works fine
> 	2.6.14-rc2: works fine
> 	2.6.14-rc2 + linus.patch (from -mm1): works fine
> 	2.6.14-rc2-mm1: hangs on boot
> 
> I looked through all the changes in "drivers/ide/" in -mm
> and none of them seemed to cause the problem. I added tracing
> to figure out whats happening. It hangs while doing, "do_probe()"
> Here is the calling sequence:
> 	 
> 	ide_scan_pcidev()
> 	   amd74xx_probe()
> 	     ide_setup_pci_device()
> 	       probe_hwif_init_with_fixup()
> 	         probe_hwif()
> 	           probe_for_drive()
> 	            do_probe()
> 	         
> If anyone has fixes/debug to try, please let me know.

If you have quilt(1) installed and don't mind a couple recompiles, you
can do a bisection on -mm patches:

1) Unpack clean 2.6.14-rc2.
2) Apply attached patch to it ("bisect-mm" script).
3) chmod 755 ./bisect-mm

4) cp -r $WHATEVER/broken-out patches	# copy broken out -mm to the top
					# level directory

"Dumb" mode:

5)	./bisect-mm start
6)	./bisect-mm apply
					# wait until patches are applied
					# or reverted
7)		rebuild
		reboot
8)	./bisect-mm good		# if it boots fine, or
	./bisect-mm bad
		goto 6

Continue until it says "Sucker is ...".

You can also enter "smart" mode after reading comment at the beginning
of the script. It can save your some recompiles.

--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bisect-mm.patch"

[PATCH -mm v2] Bisecting through -mm with quilt

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

--tKW2IUtsqtDRztdT--

