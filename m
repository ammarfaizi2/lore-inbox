Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbVAXWtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbVAXWtR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVAXWrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:47:45 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:64505 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261701AbVAXWmK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:42:10 -0500
From: Nick Pollitt <npollitt@mvista.com>
Organization: MontaVista
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: Configure mangles hex values
Date: Mon, 24 Jan 2005 14:41:56 -0800
User-Agent: KMail/1.7.2
Cc: kaos@sgi.com, Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200501241416.36422.npollitt@mvista.com>
In-Reply-To: <200501241416.36422.npollitt@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501241441.56586.npollitt@mvista.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry about previous message.

The hex function in scripts/Configure strips the leading 0x from hex values.  
The 0x needs to be there in autoconf.h, and stripping it out causes the 
following problematic scenario:

If I start with a hex value in my config file like this:
CONFIG_LOWMEM_SIZE=0x40000000
and then run make oldconfig, it strips out the '0x' so I end up with this:
CONFIG_LOWMEM_SIZE=40000000
Then if I run make xconfig, it doesn't think this is a valid hex value, so it
replaces my value with the default:
CONFIG_LOWMEM_SIZE=0x20000000

The following patch removes the lines that strip out 0x, and inserts the 0x if 
appropriate.

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
