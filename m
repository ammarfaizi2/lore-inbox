Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVBNF7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVBNF7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 00:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVBNF7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 00:59:35 -0500
Received: from static64-74.dsl-blr.eth.net ([61.11.64.74]:31492 "EHLO
	linmail.globaledgesoft.com") by vger.kernel.org with ESMTP
	id S261350AbVBNF7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 00:59:31 -0500
Message-ID: <42103DC7.1090107@globaledgesoft.com>
Date: Mon, 14 Feb 2005 11:27:27 +0530
From: krishna <krishna.c@globaledgesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: generating bus read cycles.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Can anyone explain that, how can (void)*reg_addr; generate a read cycle 
on the bus.
And Is there any source which clearly explains about setup of DMA and 
How to do DMA transfers.

Regards,
Krishna Chaitanya


/*
 * The codec register read operation requires 3 read cycles on PXA250 in 
order
 * to guarrantee that good read data can be returned.
 *            _             _              _            _
 *sync: _____| |_addr______| |_data1______| |__data2___| |__data_n__
 *SDONE:__            _              _              _______________
 *        |_addr1____| |__addr2_____| |__addr_n____|
 *       ^
 *       First read begins
 *                   ^ SDONE usually goes true in the latter half of AC 
link frame
 *                     ^ Second read begins, but data from codec hasn't 
arrived yet!
 *                                  ^ second read ends, from 1 to 3 
frames AFTER frame
 *                                    in which the address goes out!
 *                                    ^ Third read begins from one to 3 
frames after theR
 *                                      initial frame, data from codec 
guarranteed to bee
                                                                                                                              
 
 *                                      available by this time.
 *                                                 ^ read cycle ends.
 * Note how reads can be pipelined, possibly useful for reading touch panel
 * control registers or rapid sampling of codec gpio lines.
 */
                                                                                                                              
 
static struct completion CAR_completion;
static DECLARE_MUTEX(CAR_mutex);
                                                                                                                              
 
static u16 pxa_ac97_read(struct ac97_codec *codec, u8 reg)
{
        u16 val = -1;
  down(&CAR_mutex);
        if (!(CAR & CAR_CAIP)) {
                volatile u32 *reg_addr = (u32 *)&PAC_REG_BASE + (reg >> 1);
                                                                                                                               

                init_completion(&CAR_completion);
                (void)*reg_addr;
                wait_for_completion(&CAR_completion);
                init_completion(&CAR_completion);
                (void)*reg_addr; // This initiates second read cycle, 
but codec data isnn't here yet...
                wait_for_completion(&CAR_completion);
                if (GSR & GSR_RDCS) {
                        GSR |= GSR_RDCS;
                        printk(KERN_CRIT __FUNCTION__": read codec 
register timeout.\n"))
;
                }
                init_completion(&CAR_completion);
                val = *reg_addr; // ahh, that's better. But we've just 
started another cycle...
                wait_for_completion(&CAR_completion);  //this, along 
with trailing delayy
, avoids hassle with CAR_CAIP bit
                udelay(20);  //don't come back too soon...
        } else {
                printk(KERN_CRIT __FUNCTION__": CAR_CAIP already set\n");
        }
        up(&CAR_mutex);
        //printk("%s(0x%02x) = 0x%04x\n", __FUNCTION__, reg, val);
        return val;
}

