Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVAXWZO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVAXWZO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVAXWZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:25:11 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:6388 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261672AbVAXWQm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:16:42 -0500
From: Nick Pollitt <npollitt@mvista.com>
Organization: MontaVista
Subject: Configure mangles hex values
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Date: Mon, 24 Jan 2005 14:16:36 -0800
Content-Disposition: inline
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: kaos@sgi.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_2uW9BjZ7gZeRNET";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200501241416.36422.npollitt@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When doing a make oldconfig, the hex function strips the leading '0x' from hex 
values.  The '0x' is needed in the final autoconf.h, and its absence causes 
the following problem.

If I start with a hex value in my config file like this:
CONFIG_LOWMEM_SIZE=0x40000000
When I run make oldconfig, it strips out the '0x' leaving this:
CONFIG_LOWMEM_SIZE=40000000
Then if I run make xconfig, this is not considered a valid hex value, so it
replaces my value with the default:
CONFIG_LOWMEM_SIZE=0x20000000

The following patch removes the lines that strip the 0x from the hex value.  
It also checks the result for the leading 0x and inserts it if necessary.

--- scripts/Configure.orig 2005-01-24 13:31:55.000000000 -0800
+++ scripts/Configure 2005-01-24 13:34:20.000000000 -0800
@@ -378,15 +378,18 @@
 function hex () {
  old=$(eval echo "\${$2}")
  def=${old:-$3}
- def=${def#*[x,X]}
  while :; do
    readln "$1 ($2) [$def] " "$def" "$old"
-   ans=${ans#*[x,X]}
-   if expr "$ans" : '[0-9a-fA-F][0-9a-fA-F]*$' > /dev/null; then
-     define_hex "$2" "0x$ans"
+   if expr "$ans" : '0x[0-9a-fA-F][0-9a-fA-F]*$' > /dev/null; then
+     define_hex "$2" "$ans"
      break
    else
-     help "$2"
+     if expr "$ans" : '[0-9a-fA-F][0-9a-fA-F]*$' > /dev/null; then
+       define_hex "$2" "0x$ans"
+       break
+     else
+       help "$2"
+     fi
    fi
  done
 }
