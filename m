Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbTJ3VRx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 16:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262848AbTJ3VRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 16:17:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29841 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262819AbTJ3VRt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 16:17:49 -0500
Message-ID: <3FA17FEC.2080203@pobox.com>
Date: Thu, 30 Oct 2003 16:17:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] Re: 2.6.0-test9-mjb1
References: <14860000.1067544022@flay>  <3FA171DD.5060406@pobox.com> <1067548047.1028.19.camel@nighthawk>
In-Reply-To: <1067548047.1028.19.camel@nighthawk>
Content-Type: multipart/mixed;
 boundary="------------080303000003020903000101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080303000003020903000101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Dave Hansen wrote:
> On Thu, 2003-10-30 at 12:17, Jeff Garzik wrote:
> 
>>Martin J. Bligh wrote:
>>
>>>e1000 fixes
>>
>>Um...   any e1000 fixes you have, please forward them to me and Intel 
>>rather than letting them languish in a tree.
> 
> 
> There aren't any in there right now.  The patches that Martin is
> referring to were probably a couple from Anton that got fixed and merged
> long, long ago.  There's one that we keep around for ppc64, but it's not
> applicable to any other architectures and it's not really mainline
> material anyway.  


well, there's still this patch...

--------------080303000003020903000101
Content-Type: text/plain;
 name="e1000_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="e1000_patch"

--- ./drivers/net/e1000/e1000_hw.c.orig	2003-10-30 09:29:52.000000000 -0500
+++ ./drivers/net/e1000/e1000_hw.c	2003-10-30 09:30:39.000000000 -0500
@@ -4522,8 +4522,8 @@ uint32_t
 e1000_read_reg_io(struct e1000_hw *hw,
                   uint32_t offset)
 {
-    uint32_t io_addr = hw->io_base;
-    uint32_t io_data = hw->io_base + 4;
+    unsigned long io_addr = hw->io_base;
+    unsigned long io_data = hw->io_base + 4;
 
     e1000_io_write(hw, io_addr, offset);
     return e1000_io_read(hw, io_data);
@@ -4542,8 +4542,8 @@ e1000_write_reg_io(struct e1000_hw *hw,
                    uint32_t offset,
                    uint32_t value)
 {
-    uint32_t io_addr = hw->io_base;
-    uint32_t io_data = hw->io_base + 4;
+    unsigned long io_addr = hw->io_base;
+    unsigned long io_data = hw->io_base + 4;
 
     e1000_io_write(hw, io_addr, offset);
     e1000_io_write(hw, io_data, value);
--- ./drivers/net/e1000/e1000_hw.h.orig	2003-10-30 09:30:48.000000000 -0500
+++ ./drivers/net/e1000/e1000_hw.h	2003-10-30 09:32:04.000000000 -0500
@@ -317,9 +317,9 @@ void e1000_pci_clear_mwi(struct e1000_hw
 void e1000_read_pci_cfg(struct e1000_hw *hw, uint32_t reg, uint16_t * value);
 void e1000_write_pci_cfg(struct e1000_hw *hw, uint32_t reg, uint16_t * value);
 /* Port I/O is only supported on 82544 and newer */
-uint32_t e1000_io_read(struct e1000_hw *hw, uint32_t port);
+uint32_t e1000_io_read(struct e1000_hw *hw, unsigned long port);
 uint32_t e1000_read_reg_io(struct e1000_hw *hw, uint32_t offset);
-void e1000_io_write(struct e1000_hw *hw, uint32_t port, uint32_t value);
+void e1000_io_write(struct e1000_hw *hw, unsigned long port, uint32_t value);
 void e1000_write_reg_io(struct e1000_hw *hw, uint32_t offset, uint32_t value);
 int32_t e1000_config_dsp_after_link_change(struct e1000_hw *hw, boolean_t link_up);
 int32_t e1000_set_d3_lplu_state(struct e1000_hw *hw, boolean_t active);
@@ -978,7 +978,7 @@ struct e1000_hw {
     e1000_ms_type master_slave;
     e1000_ms_type original_master_slave;
     e1000_ffe_config ffe_config_state;
-    uint32_t io_base;
+    unsigned long io_base;
     uint32_t phy_id;
     uint32_t phy_revision;
     uint32_t phy_addr;
--- ./drivers/net/e1000/e1000_main.c.orig	2003-10-30 09:32:12.000000000 -0500
+++ ./drivers/net/e1000/e1000_main.c	2003-10-30 09:32:39.000000000 -0500
@@ -2621,13 +2621,13 @@ e1000_write_pci_cfg(struct e1000_hw *hw,
 }
 
 uint32_t
-e1000_io_read(struct e1000_hw *hw, uint32_t port)
+e1000_io_read(struct e1000_hw *hw, unsigned long port)
 {
 	return inl(port);
 }
 
 void
-e1000_io_write(struct e1000_hw *hw, uint32_t port, uint32_t value)
+e1000_io_write(struct e1000_hw *hw, unsigned long port, uint32_t value)
 {
 	outl(value, port);
 }

--------------080303000003020903000101--

