Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVBYVqc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVBYVqc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 16:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVBYVqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 16:46:32 -0500
Received: from mail.kroah.org ([69.55.234.183]:5295 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262253AbVBYVo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 16:44:57 -0500
Date: Fri, 25 Feb 2005 13:44:39 -0800
From: Greg KH <greg@kroah.com>
To: Corey Minyard <minyard@acm.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] I2C patch 2 - break up the SMBus formatting
Message-ID: <20050225214439.GC27270@kroah.com>
References: <421E62DD.5030608@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <421E62DD.5030608@acm.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 05:27:25PM -0600, Corey Minyard wrote:
> +/*
> + * Hold a queue of I2C operations to perform, and used to pass data
> + * around.
> + */
> +typedef void (*i2c_op_done_cb)(struct i2c_op_q_entry *entry);
> +
> +#define I2C_OP_I2C	0
> +#define I2C_OP_SMBUS	1
> +struct i2c_op_q_entry {
> +	/* The result will be set to the result of the operation when
> +	   it completes. */
> +	s32 result;
> +
> +	/**************************************************************/
> +	/* Public interface.  The user should set these up (and the
> +	   proper structure below). */
> +	int            xfer_type;
> +
> +	/* Handler may be called from interrupt context, so be
> +	   careful. */
> +	i2c_op_done_cb handler;
> +	void           *handler_data;
> +
> +	/* Note that this is not a union because an smbus operation
> +	   may be converted into an i2c operation (thus both
> +	   structures will be used).  The data in these may be changd
> +	   by the driver. */
> +	struct {
> +		struct i2c_msg *msgs;
> +		int num;
> +	} i2c;
> +	struct {
> +		/* Addr and flags are filled in by the non-blocking
> +		   send routine that takes a client. */
> +		u16 addr;
> +		unsigned short flags;
> +
> +		char read_write;
> +		u8 command;
> +
> +		/* Note that the size is *not* the length of the data.
> +		   It is the transaction type, like I2C_SMBUS_QUICK
> +		   and the ones after that below.  If this is a block
> +		   transaction, the length of the rest of the data is
> +		   in the first byte of the data, for both transmit
> +		   and receive. */
> +		int size;
> +		union i2c_smbus_data *data;
> +	} smbus;
> +
> +	/**************************************************************/
> +	/* For use by the bus interface.  The bus interface sets the
> +	   timeout in microseconds until the next poll operation.
> +	   This *must* be set in the start operation.  The time_left
> +	   and data can be used for anything the bus interface likes.
> +	   data will be set to NULL before being started so the bus
> +	   interface can use that to tell if it has been set up
> +	   yet. */
> +	unsigned int call_again_us;
> +	long         time_left;
> +	void         *data;
> +
> +	/**************************************************************/
> +	/* Internals */
> +	struct list_head  link;
> +	struct completion *start;
> +	atomic_t          completed;
> +	unsigned int      started : 1;
> +	unsigned int      use_timer : 1;
> +	u8                swpec;
> +	u8                partial;
> +	void (*complete)(struct i2c_adapter    *adap,
> +			 struct i2c_op_q_entry *entry);
> +
> +	/* It's wierd, but we use a usecount to track if an q entry is
> +	   in use and when it should be reported back to the user. */
> +	atomic_t usecount;

Please use a kref here instead of rolling your own.

Oh, and can you cc: your patches to the sensors mailing list so the
other i2c developers are aware of them and can comment?  I'll stick with
just applying your first patch for now.

thanks,

greg k-h
