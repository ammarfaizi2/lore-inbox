Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVBHTfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVBHTfx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 14:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVBHTfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 14:35:53 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:30405 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261639AbVBHTf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 14:35:28 -0500
Message-ID: <420913D1.2000205@sgi.com>
Date: Tue, 08 Feb 2005 13:32:33 -0600
From: Patrick Gefre <pfg@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Gefre <pfg@sgi.com>
CC: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       matthew@wil.cx, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: [PATCH] Altix : ioc4 serial driver support
References: <20050103140938.GA20070@infradead.org> <Pine.SGI.3.96.1050131164059.62785B-100000@fsgi900.americas.sgi.com> <20050201092335.GB28575@infradead.org> <420139BF.4000100@sgi.com> <20050202215716.GA23253@infradead.org> <42079029.5040401@sgi.com> <20050207162525.GA15926@infradead.org> <4208EE3A.6010500@sgi.com>
In-Reply-To: <4208EE3A.6010500@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've update the patch with changes from the comments below.

ftp://oss.sgi.com/projects/sn2/sn2-update/033-ioc4-support

As usual forgot this:

Signed-off-by: Patrick Gefre <pfg@sgi.com>




Patrick Gefre wrote:
> I've update the patch with changes from the comments below.
> 
> ftp://oss.sgi.com/projects/sn2/sn2-update/033-ioc4-support
> 
> 
> 
> 
> Christoph Hellwig wrote:
> 
>> On Mon, Feb 07, 2005 at 09:58:33AM -0600, Patrick Gefre wrote:
>>
>>> Latest version with review mods:
>>> ftp://oss.sgi.com/projects/sn2/sn2-update/033-ioc4-support
>>
>>
>>
>>
>>  - still not __iomem annotations.
> 
> 
> I *think* I have this right ??
> 
> 
> 
>>  - still a ->remove method
>>
>> more comments (mostly nipicks I missed last time, nothing too exciting):
>>
>>
>> +#define DEVICE_NAME_DYNAMIC "ttyIOC0"    /* need full name for 
>> misc_register */
>>
>> this one is completely unused.
>>
>> +#define PENDING(_p)    readl(&(_p)->ip_mem->sio_ir) & _p->ip_ienb
>>
>> probably wants some braces around the macro body
>>
>> +static struct ioc4_port *get_ioc4_port(struct uart_port *the_port)
>> +{
>> +    struct ioc4_control *control = dev_get_drvdata(the_port->dev);
>> +    int ii;
>> +
>> +    if (control) {
>> +        for ( ii = 0; ii < IOC4_NUM_SERIAL_PORTS; ii++ ) {
>> +            if (!control->ic_port[ii].icp_port)
>> +                continue;
>> +            if (the_port == control->ic_port[ii].icp_port->ip_port)
>> +                return control->ic_port[ii].icp_port;
>> +        }
>> +    }
>> +    return (struct ioc4_port *)0;
>>
>> just return NULL here.
>>
>> +static irqreturn_t ioc4_intr(int irq, void *arg, struct pt_regs *regs)
>> +{
>> +    struct ioc4_soft *soft;
>> +    uint32_t this_ir, this_mir;
>> +    int xx, num_intrs = 0;
>> +    int intr_type;
>> +    int handled = 0;
>> +    struct ioc4_intr_info *ii;
>> +
>> +    soft = (struct ioc4_soft *)arg;
>> +    if (!soft)
>> +        return IRQ_NONE;    /* Polled but no ioc4 registered */
>>
>> no need to cast.  and it can't be NULL either.
>>
>> +    spin_lock_irqsave(&port->ip_lock, port_flags);
>> +    wake_up_interruptible(&info->delta_msr_wait);
>> +    spin_unlock_irqrestore(&port->ip_lock, port_flags);
>>
>> no need to lock around a wake_up()
>>
>> +    /* Start up the serial port */
>> +    spin_lock_irqsave(&port->ip_lock, port_flags);
>> +    retval = ic4_startup_local(the_port);
>> +    if (retval) {
>> +        spin_unlock_irqrestore(&port->ip_lock, port_flags);
>> +        return retval;
>> +    }
>> +    spin_unlock_irqrestore(&port->ip_lock, port_flags);
>> +    return 0;
>>
>> what about just
>>
>>     spin_lock_irqsave(&port->ip_lock, port_flags);
>>     retval = ic4_startup_local(the_port);
>>     spin_unlock_irqrestore(&port->ip_lock, port_flags);
>>     return reval;
>>
>> ?
>>     
>> +    struct ioc4_port *port = get_ioc4_port(the_port);
>> +    unsigned long port_flags;
>> +
>> +    spin_lock_irqsave(&port->ip_lock, port_flags);
>> +    ioc4_change_speed(the_port, termios, old_termios);
>> +    spin_unlock_irqrestore(&port->ip_lock, port_flags);
>> +    return;
>>
>> no need for empty returns at the end of void functions
>>
>> +static struct uart_driver ioc4_uart = {
>> +    .owner        = THIS_MODULE,
>> +    .driver_name    = "ioc4_serial",
>> +    .dev_name    = DEVICE_NAME,
>> +    .major        = DEVICE_MAJOR,
>> +    .minor        = DEVICE_MINOR,
>> +    .nr        = IOC4_NUM_CARDS * IOC4_NUM_SERIAL_PORTS,
>> +    .cons        = NULL,
>> +};
>>
>> no need to initialize .cons to zero, the compiler does that for you.
>>
>> +    if ( !request_region(tmp_addr, sizeof(struct ioc4_mem), 
>> "sioc4_mem")) {
>>
>> superflous space before the !
>>
>> +    if (!request_irq(pdev->irq, ioc4_intr, SA_SHIRQ,
>> +                "sgi-ioc4serial", (void *)soft)) {
>> +        control->ic_irq = pdev->irq;
>> +    } else {
>> +        printk(KERN_WARNING
>> +            "%s : request_irq fails for IRQ 0x%x\n ",
>> +            __FUNCTION__, pdev->irq);
>> +    }
>>
>> Can the driver work without an irq?
> 
> 
> Not in its current state.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

