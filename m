Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWGIQpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWGIQpj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 12:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWGIQpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 12:45:38 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:1443 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751330AbWGIQpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 12:45:38 -0400
From: Rob Landley <rob@landley.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Miniconfig revisited (2/3)
Date: Sun, 9 Jul 2006 12:45:43 -0400
User-Agent: KMail/1.9.1
References: <200607081621.k68GL5Oc015536@laptop11.inf.utfsm.cl>
In-Reply-To: <200607081621.k68GL5Oc015536@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3KTsExayPbGfekB"
Message-Id: <200607091245.43880.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_3KTsExayPbGfekB
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Saturday 08 July 2006 12:21 pm, Horst von Brand wrote:
> > +LENGTH=$(cat .config | wc -l)
>
> Why the cat(1)? "wc -l < .config" is the same

I believe it was originally a longer pipeline, and I can't wc the file 
directly or it'll spit out the filename, but < is indeed one less process 
spawned per loop.

> > +# Loop through all lines in the file
> > +I=1
> > +while true
> > +do
> > +  if [ $I -gt $LENGTH ]
> > +  then
> > +    break
> > +  fi
>
> Could do it with:
>
>   for I in $(seq 1 $LENGTH); do
>     ...
>   done

Makes a 1/10th of a second difference to the final runtime, but if you prefer 
that...

> or just plain read the lines
>
> > +
> > +  echo -n -e "\r"$I/$LENGTH lines $(cat "$OUTPUT" | wc -c) bytes
>
> Again, unnecessary cat(1).

Yup, a valid cleanup.

The thing is, the script's going to be dog slow no matter what I do, and most 
of the slowness isn't in the script, it's the config infrastructure 
re-parsing the config file 1500 times or so for defconfig.  (The script's 
about 3% of the runtime overhead, and the two largest chunks of that are 
printing out the progress indicator and the sed invocation right above the 
make.)  So I didn't put that much effort into optimizing it.

Someday I'd like to go in and make kconfig spit out a miniconfig directly, but 
kconfig's not really set up to do that, and touching Roman Zippel's code 
would give him the opportunity to say no again.

Anyway, here's a version with your fixes.  Thanks for the review,

Rob
-- 
Never bet against the cheap plastic solution.

--Boundary-00=_3KTsExayPbGfekB
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="shrinkconfig2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="shrinkconfig2.patch"

--- linux-2.6.17.1/scripts/shrinkconfig	2006-07-09 12:40:38.000000000 -0400
+++ linux-2.6.17.new/scripts/shrinkconfig	2006-07-09 12:12:32.000000000 -0400
@@ -0,0 +1,79 @@
+#!/bin/bash
+
+# shrinkconfig copyright 2006 by Rob Landley <rob@landley.net>
+# Licensed under the GNU General Public License version 2.
+
+if [ $# -ne 1 ]
+then
+  echo "Turns current .config into a miniconfig file."
+  echo "Usage: shrinkconfig mini.config"
+  exit 1
+fi
+
+if [ ! -f .config ]
+then
+  echo "Need a .config file to shrink."
+  exit 1
+fi
+LENGTH=$(wc -l < .config)
+
+OUTPUT="$1"
+cp .config "$OUTPUT"
+if [ $? -ne 0 ]
+then
+  echo "Couldn't create $OUTPUT"
+  exit 1
+fi
+
+# If we get interrupted, clean up the mess
+
+KERNELOUTPUT=""
+
+function cleanup
+{
+  echo
+  echo "Interrupted."
+  [ ! -z "$KERNELOUTPUT" ] && rm -rf "$KERNELOUTPUT"
+  rm "$OUTPUT"
+  exit 1
+}
+
+trap cleanup HUP INT QUIT TERM
+
+# Since the "O=" argument to make doesn't work recursively, we need to jump
+# through a few hoops to avoid overwriting the .config that we're shrinking.
+
+# If we're building out of tree, we'll have absolute paths to source and build
+# directories in the Makefile.
+
+KERNELSRC=$(sed -n -e 's/KERNELSRC[^/]*:=[^/]*//p' Makefile)
+[ -z "$KERNELSRC" ] && KERNELSRC=$(pwd)
+KERNELOUTPUT=`pwd`/.config.minitemp
+
+mkdir -p "$KERNELOUTPUT" || exit 1
+
+echo "Shrinking .config to $OUTPUT..."
+
+for I in $(seq 1 $LENGTH)
+do
+  echo -n -e "\r"$I/$LENGTH lines $(wc -c < "$OUTPUT") bytes
+
+  sed -n "${I}!p" "$OUTPUT" > "$KERNELOUTPUT"/.config.test
+  # Do a config with this file
+  make -C "$KERNELSRC" O="$KERNELOUTPUT" allnoconfig KCONFIG_ALLCONFIG="$KERNELOUTPUT"/.config.test > /dev/null
+
+  # Compare.  The date changes, so expect a small difference each time.
+  D=$(diff "$KERNELOUTPUT"/.config .config | wc -l)
+  if [ $D -eq 4 ]
+  then
+    mv "$KERNELOUTPUT"/.config.test "$OUTPUT"
+    LENGTH=$[$LENGTH-1]
+  else
+    I=$[$I + 1]
+  fi
+done
+
+rm -rf "$KERNELOUTPUT"
+
+# One extra echo to preserve status line.
+echo

--Boundary-00=_3KTsExayPbGfekB--
