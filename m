Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbUBWSJX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 13:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUBWSJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 13:09:23 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:2788 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261975AbUBWSJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 13:09:19 -0500
Date: Mon, 23 Feb 2004 19:09:12 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, perex@suse.cz, alsa@digigram.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: [patch] 2.6.3-mm3: ALSA miXart driver doesn't compile
Message-ID: <20040223180911.GL5499@fs.tum.de>
References: <20040222172200.1d6bdfae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222172200.1d6bdfae.akpm@osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 05:22:00PM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.3-mm2:
>...
>  bk-alsa.patch
>...
>  Latest versions of external trees
>...

I got four compile errors like the following in the miXart driver:

<--  snip  -->

...
  CC      sound/pci/mixart/mixart.o
In file included from sound/pci/mixart/mixart.c:33:
sound/pci/mixart/mixart.h:95: field `msg_taskq' has incomplete type
In file included from sound/pci/mixart/mixart.c:35:
sound/pci/mixart/mixart_core.h:602: parse error before 
`snd_mixart_interrupt'
sound/pci/mixart/mixart_core.h:602: warning: type defaults to `int' in 
declaration of `snd_mixart_interrupt'
sound/pci/mixart/mixart_core.h:602: warning: data definition has no type 
or storage class
sound/pci/mixart/mixart.c: In function `snd_mixart_hw_params':
sound/pci/mixart/mixart.c:604: warning: unsigned int format, different 
type arg (arg 5)
sound/pci/mixart/mixart.c: In function `snd_mixart_free':
sound/pci/mixart/mixart.c:1043: warning: implicit declaration of 
function `free_irq'
sound/pci/mixart/mixart.c: In function `snd_mixart_probe':
sound/pci/mixart/mixart.c:1301: warning: implicit declaration of 
function `request_irq'
sound/pci/mixart/mixart.c:1325: warning: implicit declaration of 
function `tasklet_init'
make[3]: *** [sound/pci/mixart/mixart.o] Error 1

<--  snip  -->

The patch below fixes these issues for me.

cu
Adrian


--- linux-2.6.3-mm3/sound/pci/mixart/mixart.c.old	2004-02-23 18:28:08.000000000 +0100
+++ linux-2.6.3-mm3/sound/pci/mixart/mixart.c	2004-02-23 18:28:27.000000000 +0100
@@ -23,6 +23,7 @@
 
 #include <sound/driver.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <sound/core.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
--- linux-2.6.3-mm3/sound/pci/mixart/mixart_core.c.old	2004-02-23 18:30:18.000000000 +0100
+++ linux-2.6.3-mm3/sound/pci/mixart/mixart_core.c	2004-02-23 18:30:38.000000000 +0100
@@ -20,6 +20,7 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#include <linux/interrupt.h>
 #include <sound/driver.h>
 #include <sound/core.h>
 #include "mixart.h"
--- linux-2.6.3-mm3/sound/pci/mixart/mixart_hwdep.c.old	2004-02-23 18:32:49.000000000 +0100
+++ linux-2.6.3-mm3/sound/pci/mixart/mixart_hwdep.c	2004-02-23 18:33:01.000000000 +0100
@@ -20,6 +20,7 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
+#include <linux/interrupt.h>
 #include <sound/driver.h>
 #include <sound/core.h>
 #include "mixart.h"
--- linux-2.6.3-mm3/sound/pci/mixart/mixart_mixer.c.old	2004-02-23 18:34:42.000000000 +0100
+++ linux-2.6.3-mm3/sound/pci/mixart/mixart_mixer.c	2004-02-23 18:34:57.000000000 +0100
@@ -23,6 +23,7 @@
 #include <sound/driver.h>
 #include <linux/time.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
 #include <sound/core.h>
 #include "mixart.h"
 #include "mixart_core.h"
