Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268070AbUIUVCx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268070AbUIUVCx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 17:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268053AbUIUVCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 17:02:52 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:505 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268081AbUIUVCH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 17:02:07 -0400
Message-ID: <9e47339104092114025e763da8@mail.gmail.com>
Date: Tue, 21 Sep 2004 17:02:00 -0400
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH][2.6] Add command function to struct i2c_adapter
Cc: Michael Hunold <hunold-ml@web.de>, Greg KH <greg@kroah.com>,
       LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040921223325.66b07f78.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <414F111C.9030809@linuxtv.org> <20040921154111.GA13028@kroah.com>
	 <41506099.8000307@web.de> <9e4733910409211039273d5a2f@mail.gmail.com>
	 <20040921223325.66b07f78.khali@linux-fr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the special wake code for older monitors.  ATI supplied it and
it is in the radeon driver.

My understanding that this is a generic problem with old DDC monitors
so the code should be in a DDC I2C driver instead of being added to
all of the video drivers. I don't want the DDC driver to decode the
EDID data, it just needs to handle this problem.

I can say that even my current monitors don't always return the EDID
data without being woken up. The only way to see this is to have
multiple video cards in your PC. The secondary cards won't be reset by
the kernel. Reseting the card will run the BIOS which wakes the
monitors up. If you try to get the EDID from the secondary cards
before they are reset you won't be able to reliably read it.

int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn,
u8 **out_edid)
{
	u32 reg = rinfo->i2c[conn-1].ddc_reg;
	u8 *edid = NULL;
	int i, j;

	OUTREG(reg, INREG(reg) & 
			~(VGA_DDC_DATA_OUTPUT | VGA_DDC_CLK_OUTPUT));

	OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
	(void)INREG(reg);

	for (i = 0; i < 3; i++) {
		/* For some old monitors we need the
		 * following process to initialize/stop DDC
		 */
		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
		(void)INREG(reg);
		msleep(13);

		OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
		(void)INREG(reg);
		for (j = 0; j < 5; j++) {
			msleep(10);
			if (INREG(reg) & VGA_DDC_CLK_INPUT)
				break;
		}
		if (j == 5)
			continue;

		OUTREG(reg, INREG(reg) | VGA_DDC_DATA_OUT_EN);
		(void)INREG(reg);
		msleep(15);
		OUTREG(reg, INREG(reg) | VGA_DDC_CLK_OUT_EN);
		(void)INREG(reg);
		msleep(15);
		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
		(void)INREG(reg);
		msleep(15);

		/* Do the real work */
		edid = radeon_do_probe_i2c_edid(&rinfo->i2c[conn-1]);

		OUTREG(reg, INREG(reg) | 
				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
		(void)INREG(reg);
		msleep(15);
		
		OUTREG(reg, INREG(reg) & ~(VGA_DDC_CLK_OUT_EN));
		(void)INREG(reg);
		for (j = 0; j < 10; j++) {
			msleep(10);
			if (INREG(reg) & VGA_DDC_CLK_INPUT)
				break;
		}

		OUTREG(reg, INREG(reg) & ~(VGA_DDC_DATA_OUT_EN));
		(void)INREG(reg);
		msleep(15);
		OUTREG(reg, INREG(reg) |
				(VGA_DDC_DATA_OUT_EN | VGA_DDC_CLK_OUT_EN));
		(void)INREG(reg);
		if (edid)
			break;
	}
	if (out_edid)
		*out_edid = edid;
	if (!edid) {
		RTRACE("radeonfb: I2C (port %d) ... not found\n", conn);
		return MT_NONE;
	}
	if (edid[0x14] & 0x80) {
		/* Fix detection using BIOS tables */
		if (rinfo->is_mobility /*&& conn == ddc_dvi*/ &&
		    (INREG(LVDS_GEN_CNTL) & LVDS_ON)) {
			RTRACE("radeonfb: I2C (port %d) ... found LVDS panel\n", conn);
			return MT_LCD;
		} else {
			RTRACE("radeonfb: I2C (port %d) ... found TMDS panel\n", conn);
			return MT_DFP;
		}
	}
       	RTRACE("radeonfb: I2C (port %d) ... found CRT display\n", conn);
	return MT_CRT;
}

-- 
Jon Smirl
jonsmirl@gmail.com
