Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbVJFRen@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbVJFRen (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 13:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbVJFRen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 13:34:43 -0400
Received: from fmr19.intel.com ([134.134.136.18]:64401 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751258AbVJFRem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 13:34:42 -0400
From: Mark Gross <mgross@linux.intel.com>
Organization: Intel
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: Fwd: Telecom Clock Driver for MPCBL0010 ATCA computer blade
Date: Thu, 6 Oct 2005 10:31:36 -0700
User-Agent: KMail/1.7.1
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       Sebastien.Bouchard@ca.kontron.com, mark.gross@intel.com
References: <200510060803.21470.mgross@linux.intel.com> <20051006172427.GB22974@mipter.zuzino.mipt.ru>
In-Reply-To: <20051006172427.GB22974@mipter.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510061031.36271.mgross@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 October 2005 10:24, Alexey Dobriyan wrote:
> > --- linux-2.6.14-rc2-mm2/drivers/char/tlclk.c
> > +++ linux-2.6.14-rc2-mm2-tlclk/drivers/char/tlclk.c
> 
> Can you drop ioctl part of interface and leave only sysfs one?
> 

I would like to keep if for a little while because the hardware validation 
guys are still using test harnesses written for the 2.4 kernel driver 
version.  However; I am willing to pull this block if that would help in 
getting this driver into the kernel.

--mgross


> > +#ifdef TLCLK_IOCTL
> > +static int
> > +tlclk_ioctl(struct inode *inode,
> > +     struct file *filp, unsigned int cmd, unsigned long arg)
> > +{
> > + unsigned long flags;
> > + unsigned char val;
> > + int ret_val = 0;
> > +
> > + val = (unsigned char)arg;
> > + if (_IOC_TYPE(cmd) != TLCLK_IOC_MAGIC)
> > +  return -ENOTTY;
> > +
> > + if (_IOC_NR(cmd) > TLCLK_IOC_MAXNR)
> > +  return -ENOTTY;
> > +
> > + spin_lock_irqsave(&event_lock, flags);
> > + switch (cmd) {
> > + case IOCTL_RESET:
> > +		SET_PORT_BITS(TLCLK_REG4, 0xfd, val);
> > +		break;
> > +	case IOCTL_MODE_SELECT:
> > +		SET_PORT_BITS(TLCLK_REG0, 0xcf, val);
> > +		break;
> > +	case IOCTL_REFALIGN:
> > +		/* GENERATING 0 to 1 transistion */
> > +		SET_PORT_BITS(TLCLK_REG0, 0xf7, 0);
> > +		udelay(2);
> > +		SET_PORT_BITS(TLCLK_REG0, 0xf7, 0x08);
> > +		udelay(2);
> > +		SET_PORT_BITS(TLCLK_REG0, 0xf7, 0);
> > +		break;
> > +	case IOCTL_HARDWARE_SWITCHING:
> > +		SET_PORT_BITS(TLCLK_REG0, 0x7f, val);
> > +		break;
> > +	case IOCTL_HARDWARE_SWITCHING_MODE:
> > +		SET_PORT_BITS(TLCLK_REG0, 0xbf, val);
> > +		break;
> > +	case IOCTL_FILTER_SELECT:
> > +		SET_PORT_BITS(TLCLK_REG0, 0xfb, val);
> > +		break;
> > +	case IOCTL_SELECT_REF_FREQUENCY:
> > +		SET_PORT_BITS(TLCLK_REG1, 0xfd, val);
> > +		break;
> > +	case IOCTL_SELECT_REDUNDANT_CLOCK:
> > +		SET_PORT_BITS(TLCLK_REG1, 0xfe, val);
> > +		break;
> > +	case IOCTL_SELECT_AMCB1_TRANSMIT_CLOCK:
> > +		if ((val == CLK_8kHz) || (val == CLK_16_384MHz)) {
> > +			SET_PORT_BITS(TLCLK_REG3, 0xf8, 0x5);
> > +			SET_PORT_BITS(TLCLK_REG1, 0xfb, ~val);
> > +		} else if (val >= CLK_8_592MHz) {
> > +			SET_PORT_BITS(TLCLK_REG3, 0xf8, 0x7);
> > +			switch (val) {
> > +			case CLK_8_592MHz:
> > +				SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
> > +				break;
> > +			case CLK_11_184MHz:
> > +				SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
> > +				break;
> > +			case CLK_34_368MHz:
> > +				SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
> > +				break;
> > +			case CLK_44_736MHz:
> > +				SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
> > +				break;
> > +			}
> > +		} else
> > +			SET_PORT_BITS(TLCLK_REG3, 0xf8, val);
> > +		break;
> > +	case IOCTL_SELECT_AMCB2_TRANSMIT_CLOCK:
> > +		if ((val == CLK_8kHz) || (val == CLK_16_384MHz)) {
> > +			SET_PORT_BITS(TLCLK_REG3, 0xc7, 0x28);
> > +			SET_PORT_BITS(TLCLK_REG1, 0xfb, ~val);
> > +		} else if (val >= CLK_8_592MHz) {
> > +			SET_PORT_BITS(TLCLK_REG3, 0xc7, 0x38);
> > +			switch (val) {
> > +			case CLK_8_592MHz:
> > +				SET_PORT_BITS(TLCLK_REG0, 0xfc, 1);
> > +				break;
> > +			case CLK_11_184MHz:
> > +				SET_PORT_BITS(TLCLK_REG0, 0xfc, 0);
> > +				break;
> > +			case CLK_34_368MHz:
> > +				SET_PORT_BITS(TLCLK_REG0, 0xfc, 3);
> > +				break;
> > +			case CLK_44_736MHz:
> > +				SET_PORT_BITS(TLCLK_REG0, 0xfc, 2);
> > +				break;
> > +			}
> > +		} else
> > +			SET_PORT_BITS(TLCLK_REG3, 0xc7, val << 3);
> > +		break;
> > +	case IOCTL_TEST_MODE:
> > +		SET_PORT_BITS(TLCLK_REG4, 0xfd, 2);
> > +		break;
> > +	case IOCTL_ENABLE_CLKA0_OUTPUT:
> > +		SET_PORT_BITS(TLCLK_REG2, 0xfe, val);
> > +		break;
> > +	case IOCTL_ENABLE_CLKB0_OUTPUT:
> > +		SET_PORT_BITS(TLCLK_REG2, 0xfd, val << 1);
> > +		break;
> > +	case IOCTL_ENABLE_CLKA1_OUTPUT:
> > +		SET_PORT_BITS(TLCLK_REG2, 0xfb, val << 2);
> > +		break;
> > +	case IOCTL_ENABLE_CLKB1_OUTPUT:
> > +		SET_PORT_BITS(TLCLK_REG2, 0xf7, val << 3);
> > +		break;
> > +	case IOCTL_ENABLE_CLK3A_OUTPUT:
> > +		SET_PORT_BITS(TLCLK_REG3, 0xbf, val << 6);
> > +		break;
> > +	case IOCTL_ENABLE_CLK3B_OUTPUT:
> > +		SET_PORT_BITS(TLCLK_REG3, 0x7f, val << 7);
> > +		break;
> > +	case IOCTL_READ_ALARMS:
> > +		ret_val = (inb(TLCLK_REG2) & 0xf0);
> > +		break;
> > +	case IOCTL_READ_INTERRUPT_SWITCH:
> > +		ret_val = inb(TLCLK_REG6);
> > +		break;
> > +	case IOCTL_READ_CURRENT_REF:
> > +		ret_val = ((inb(TLCLK_REG1) & 0x08) >> 3);
> > +		break;
> > +	}
> > +	spin_unlock_irqrestore(&event_lock, flags);
> > +
> > +	return ret_val;
> > +}
> > +#endif
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
--mgross
BTW: This may or may not be the opinion of my employer, more likely not.  
