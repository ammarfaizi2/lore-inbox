Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129030AbQKEMLX>; Sun, 5 Nov 2000 07:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129038AbQKEMLM>; Sun, 5 Nov 2000 07:11:12 -0500
Received: from pop.gmx.net ([194.221.183.20]:40667 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129030AbQKEMK6>;
	Sun, 5 Nov 2000 07:10:58 -0500
Message-ID: <3A054DC8.1D9701EC@gmx.de>
Date: Sun, 05 Nov 2000 13:08:40 +0100
From: Bernd Harries <bha@gmx.de>
Reply-To: bha@gmx.de
Organization: BHA Industries
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org
Subject: 2.2.x: Secret stack size limit in Driver file-ops??? (Was:are Generic 
 ioctls a good thing?)
In-Reply-To: <3A01C6FA.25A90016@gmx.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi kernel hackers,

Is there a limit to the stack size (automatic variables) in driver methods, esp.
ioctl?

I was just implementing some generic ioctls where the size field and cmd field
are defined at runtime. For testing I use a kernbuf on the stack.

The driver's ioctl interface, which is normally a big case construction, looks
like this, the default case is another switch:

xyz_ioctl(..., ..., unsigned int request, unsigned long arg)
{

  ----some smaller declarations----

  switch(request)
  {
    ...
    case IOR_GET_FIX:
    {
      fix_par_t   fix_par;   /* small struct */

      ----some code----
      if(copy_to_user( , , sizeof(fix_par)))  return(-EFAULT);  
      break;
    }
    ...

    default:
    {
      switch(request & 0xF000FF00)
      {
        case IOW_000_G_00:
        {
          UINT32    kernbuf[0x0400];  /* is this too much??? */

          if(copy_from_user( , , dyn_size))  return(-EFAULT);
          ----some code----
          break;
        }
        case IOR_000_G_00:
        {
          UINT32    kernbuf[0x0400];  /* how much is allowed??? */

          ----some code----
          if(copy_to_user( , , dyn_size))  return(-EFAULT);
          break;
        }

      }
      /*endswitch(request & 0xF000FF00)*/
    }
    /*endcase default:*/
  }
  /*endswitch(request)*/
}
/*endproc()*/

Having this and testing not yet the generic ioctls, but the older, once working
'primitive' ioctls, I experienced that suddenly copy_to_user would not work any
more and return the complete length as remainder. The whole system seemed to
behave strange the more often I started the testprogram. Compiling the driver
module again would show strange error messages.

Observe, that the case-Block with the additional kernbuf was not even entered,
because the IOR_GET_FIX: returned an error "Bad address" or so.

Today I reduced the kernbuf to 4 * UINT32 and it seems to work. I will next try
to use a static kernbuf of 0x400 * UINT32...

In the Linux Device Drivers book I didn't find 'stack size' or similar in the
index. Are there any limits on the stacksize? If yes, how large are they and why
would the driver behave so stange and not oops or hang? I fear, my filesystem on
the test Box could be damaged. I saw this bad addres error quite some times and
suddenly make modules complained about strange contents in .config...

Does gcc grow the stack only at the beginning of a function, or can it save the
space and re-grow it on entering code_blocks also?

Thanks for any hints,
-- 
Bernd Harries

bha@gmx.de           http://www.freeyellow.com/members/bharries
bha@nikocity.de       Tel. +49 421 809 7343 priv.  | MSB First!
harries@stn-atlas.de       +49 421 457 3966 offi.  | Linux-m68k
bernd@linux-m68k.org      8.48'21" E  52.48'52" N  | Medusa T40
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
