Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbUKJVAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUKJVAi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 16:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbUKJVAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 16:00:38 -0500
Received: from siaar1aa.compuserve.com ([149.174.40.9]:17543 "EHLO
	siaar1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S261918AbUKJVA2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 16:00:28 -0500
Message-ID: <41927F5F.4080204@compuserve.com>
Date: Wed, 10 Nov 2004 12:51:43 -0800
From: Bryan Batten <BryanBatten@compuserve.com>
Reply-To: BryanBatten@compuserve.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Pavel Roskin <proski@gnu.org>, David Gibson <hermes@gibson.dropbear.id.au>,
       Trivial Patch Monkey <trivial@rustcorp.com.au>,
       linux-kernel@vger.kernel.org
Subject: Warning Fix drivers/net/wireless in Kernel 2.6.9
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch removes the "makes pointer from integer without a cast"
warnings in orinoco code by casting the appropriate parameter to
readw, writew as (void *) in the header file hermes.h.

The underlying problem is that readw/writes boil down to low level
calls that take a pointer, while inw/outw boil down (eventually) to
low level calls that take an int. So the choice was to either cast
inw, outw parameters as (int)'s, or cast readw, writew parameters as
(void *). I chose the latter.

I suspect the truly "best" fix would be to change the underlying
inx/outx definitions to accept a pointer, so's to be consistent
with the definitions of readx/writex, but that would probably break
other stuff.

Anyway, here's the patch to hermes.h:

--- ./linux-2.6.9orig/drivers/net/wireless/hermes.h     Thu Nov  4 11:33:23 2004
+++ ./linux-2.6/drivers/net/wireless/hermes.h   Wed Nov 10 09:35:55 2004
@@ -364,12 +364,12 @@ typedef struct hermes {
  /* Register access convenience macros */
  #define hermes_read_reg(hw, off) ((hw)->io_space ? \
         inw((hw)->iobase + ( (off) << (hw)->reg_spacing )) : \
-       readw((hw)->iobase + ( (off) << (hw)->reg_spacing )))
+       readw((void *)(hw)->iobase + ( (off) << (hw)->reg_spacing )))
  #define hermes_write_reg(hw, off, val) do { \
         if ((hw)->io_space) \
                 outw_p((val), (hw)->iobase + ((off) << (hw)->reg_spacing)); \
         else \
-               writew((val), (hw)->iobase + ((off) << (hw)->reg_spacing)); \
+               writew((val), (void *)(hw)->iobase + ((off) << (hw)->reg_spacing)); \
         } while (0)
  #define hermes_read_regn(hw, name) hermes_read_reg((hw), HERMES_##name)
  #define hermes_write_regn(hw, name, val) hermes_write_reg((hw), HERMES_##name, (val))
@@ -442,7 +442,7 @@ static inline void hermes_read_words(str
                  * gcc is smart enough to fold away the two swaps on
                  * big-endian platforms. */
                 for (i = 0, p = buf; i < count; i++) {
-                       *p++ = cpu_to_le16(readw(hw->iobase + off));
+                       *p++ = cpu_to_le16(readw((void *)hw->iobase + off));
                 }
         }
  }
@@ -462,7 +462,7 @@ static inline void hermes_write_words(st
                  * hope gcc is smart enough to fold away the two swaps
                  * on big-endian platforms. */
                 for (i = 0, p = buf; i < count; i++) {
-                       writew(le16_to_cpu(*p++), hw->iobase + off);
+                       writew(le16_to_cpu(*p++), (void *)hw->iobase + off);
                 }
         }
  }
@@ -478,7 +478,7 @@ static inline void hermes_clear_words(st
                         outw(0, hw->iobase + off);
         } else {
                 for (i = 0; i < count; i++)
-                       writew(0, hw->iobase + off);
+                       writew(0, (void *)hw->iobase + off);
         }
  }
