Return-Path: <linux-kernel-owner+willy=40w.ods.org-S274137AbVBFKXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274137AbVBFKXI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 05:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274410AbVBFKXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 05:23:08 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:46307 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S274137AbVBFKUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 05:20:43 -0500
Date: Sun, 6 Feb 2005 11:18:18 +0100 (CET)
From: Armin Schindler <armin@melware.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: kkeil@suse.de, kai.germaschewski@gmx.de, isdn4linux@listserv.isdn4linux.de,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       developers@melware.de
Subject: Re: [2.6 patch] drivers/isdn/hardware/eicon/: misc possible cleanups
In-Reply-To: <20050206003556.GK3129@stusta.de>
Message-ID: <Pine.LNX.4.61.0502061110120.1053@phoenix.one.melware.de>
References: <20050206003556.GK3129@stusta.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

thanks for the proposed patch.
Making the functions static is a good idea, I will check and test this.
Removing some functions, especially from io.* and di.* is not good. These 
functions are mainly used with other sub-drivers which are not part of the
kernel. I will check if they are some really outdated and the removals in 
message.c.

Armin



On Sun, 6 Feb 2005, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make some needlessly global code static
> - dadapter.h: remoe the unused #define OLD_MAX_DESCRIPTORS
> - remove the following unused functions:
>   - di.c: pr_test_int
>   - di.c: pr_clear_int
>   - di.c: scom_out
>   - di.c: scom_ready
>   - di.c: scom_dpc
>   - di.c: quadro_clear_int
>   - io.c: outp_words_from_buffer
>   - io.c: inp_words_to_buffer
> - message.c: #if 0 some unused functions
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  drivers/isdn/hardware/eicon/capifunc.c  |    2 
>  drivers/isdn/hardware/eicon/dadapter.c  |    6 
>  drivers/isdn/hardware/eicon/dadapter.h  |    7 
>  drivers/isdn/hardware/eicon/di.c        |  201 ------------------------
>  drivers/isdn/hardware/eicon/di.h        |    5 
>  drivers/isdn/hardware/eicon/diva_didd.c |    2 
>  drivers/isdn/hardware/eicon/divamnt.c   |    4 
>  drivers/isdn/hardware/eicon/io.c        |   32 ---
>  drivers/isdn/hardware/eicon/io.h        |    5 
>  drivers/isdn/hardware/eicon/message.c   |   64 ++++---
>  drivers/isdn/hardware/eicon/os_4bri.c   |    4 
>  11 files changed, 55 insertions(+), 277 deletions(-)
> 
> --- linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/capifunc.c.old	2005-02-05 15:45:40.000000000 +0100
> +++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/capifunc.c	2005-02-05 15:45:56.000000000 +0100
> @@ -64,7 +64,7 @@
>   */
>  static void no_printf(unsigned char *, ...);
>  #include "debuglib.c"
> -void xlog(char *x, ...)
> +static void xlog(char *x, ...)
>  {
>  #ifndef DIVA_NO_DEBUGLIB
>  	va_list ap;
> --- linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/dadapter.h.old	2005-02-05 15:46:38.000000000 +0100
> +++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/dadapter.h	2005-02-05 15:47:56.000000000 +0100
> @@ -25,11 +25,10 @@
>   */
>  #ifndef __DIVA_DIDD_DADAPTER_INC__
>  #define __DIVA_DIDD_DADAPTER_INC__
> +
>  void diva_didd_load_time_init (void);
>  void diva_didd_load_time_finit (void);
> -int diva_didd_add_descriptor (DESCRIPTOR* d);
> -int diva_didd_remove_descriptor (IDI_CALL request);
> -int diva_didd_read_adapter_array (DESCRIPTOR* buffer, int length);
> -#define OLD_MAX_DESCRIPTORS     16
> +
>  #define NEW_MAX_DESCRIPTORS     64
> +
>  #endif
> --- linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/dadapter.c.old	2005-02-05 15:48:17.000000000 +0100
> +++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/dadapter.c	2005-02-05 15:48:46.000000000 +0100
> @@ -106,7 +106,7 @@
>    return adapter handle (> 0) on success
>    return -1 adapter array overflow
>    -------------------------------------------------------------------------- */
> -int diva_didd_add_descriptor (DESCRIPTOR* d) {
> +static int diva_didd_add_descriptor (DESCRIPTOR* d) {
>   diva_os_spin_lock_magic_t      irql;
>   int i;
>   if (d->type == IDI_DIMAINT) {
> @@ -143,7 +143,7 @@
>    return adapter handle (> 0) on success
>    return 0 on success
>    -------------------------------------------------------------------------- */
> -int diva_didd_remove_descriptor (IDI_CALL request) {
> +static int diva_didd_remove_descriptor (IDI_CALL request) {
>   diva_os_spin_lock_magic_t      irql;
>   int i;
>   if (request == MAdapter.request) {
> @@ -171,7 +171,7 @@
>    Read adapter array
>    return 1 if not enough space to save all available adapters
>     -------------------------------------------------------------------------- */
> -int diva_didd_read_adapter_array (DESCRIPTOR* buffer, int length) {
> +static int diva_didd_read_adapter_array (DESCRIPTOR* buffer, int length) {
>   diva_os_spin_lock_magic_t      irql;
>   int src, dst;
>   memset (buffer, 0x00, length);
> --- linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/di.h.old	2005-02-05 15:55:28.000000000 +0100
> +++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/di.h	2005-02-05 15:57:24.000000000 +0100
> @@ -81,13 +81,8 @@
>  /*------------------------------------------------------------------*/
>  void pr_out(ADAPTER * a);
>  byte pr_dpc(ADAPTER * a);
> -byte pr_test_int(ADAPTER * a);
> -void pr_clear_int(ADAPTER * a);
> -void scom_out(ADAPTER * a);
> -byte scom_dpc(ADAPTER * a);
>  byte scom_test_int(ADAPTER * a);
>  void scom_clear_int(ADAPTER * a);
> -void quadro_clear_int(ADAPTER * a);
>  /*------------------------------------------------------------------*/
>  /* OS specific functions used by IDI common code                    */
>  /*------------------------------------------------------------------*/
> --- linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/di.c.old	2005-02-05 15:55:47.000000000 +0100
> +++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/di.c	2005-02-05 17:42:51.000000000 +0100
> @@ -42,10 +42,7 @@
>  /*------------------------------------------------------------------*/
>  void pr_out(ADAPTER * a);
>  byte pr_dpc(ADAPTER * a);
> -void scom_out(ADAPTER * a);
> -byte scom_dpc(ADAPTER * a);
>  static byte pr_ready(ADAPTER * a);
> -static byte scom_ready(ADAPTER * a);
>  static byte isdn_rc(ADAPTER *, byte, byte, byte, word, dword, dword);
>  static byte isdn_ind(ADAPTER *, byte, byte, byte, PBUFFER *, byte, word);
>  /* -----------------------------------------------------------------
> @@ -59,11 +56,10 @@
>     ----------------------------------------------------------------- */
>  #if defined(XDI_USE_XLOG)
>  #define XDI_A_NR(_x_) ((byte)(((ISDN_ADAPTER *)(_x_->io))->ANum))
> +static byte xdi_xlog_sec = 0;
>  #else
>  #define XDI_A_NR(_x_) ((byte)0)
>  #endif
> -byte xdi_xlog_sec = 0;
> -void xdi_xlog (byte *msg, word code, int length);
>  static void xdi_xlog_rc_event (byte Adapter,
>                                 byte Id, byte Ch, byte Rc, byte cb, byte type);
>  static void xdi_xlog_request (byte Adapter, byte Id,
> @@ -345,192 +341,6 @@
>    }
>    return FALSE;
>  }
> -byte pr_test_int(ADAPTER * a)
> -{
> -  return a->ram_in(a,(void *)0x3ffc);
> -}
> -void pr_clear_int(ADAPTER * a)
> -{
> -  a->ram_out(a,(void *)0x3ffc,0);
> -}
> -/*------------------------------------------------------------------*/
> -/* output function                                                  */
> -/*------------------------------------------------------------------*/
> -void scom_out(ADAPTER * a)
> -{
> -  byte e_no;
> -  ENTITY  * this;
> -  BUFFERS  * X;
> -  word length;
> -  word i;
> -  word clength;
> -  byte more;
> -  byte Id;
> -  dtrc(dprintf("scom_out"));
> -        /* check if the adapter is ready to accept an request:      */
> -  e_no = look_req(a);
> -  if(!e_no)
> -  {
> -    dtrc(dprintf("no_req"));
> -    return;
> -  }
> -  if(!scom_ready(a))
> -  {
> -    dtrc(dprintf("not_ready"));
> -    return;
> -  }
> -  this = entity_ptr(a,e_no);
> -  dtrc(dprintf("out:Req=%x,Id=%x,Ch=%x",this->Req,this->Id,this->ReqCh));
> -  next_req(a);
> -        /* now copy the data from the current data buffer into the  */
> -        /* adapters request buffer                                  */
> -  length = 0;
> -  i = this->XCurrent;
> -  X = PTR_X(a, this);
> -  while(i<this->XNum && length<270) {
> -    clength = MIN((word)(270-length),X[i].PLength-this->XOffset);
> -    a->ram_out_buffer(a,
> -                      &RAM->XBuffer.P[length],
> -                      PTR_P(a,this,&X[i].P[this->XOffset]),
> -                      clength);
> -    length +=clength;
> -    this->XOffset +=clength;
> -    if(this->XOffset==X[i].PLength) {
> -      this->XCurrent = (byte)++i;
> -      this->XOffset = 0;
> -    }
> -  }
> -  a->ram_outw(a, &RAM->XBuffer.length, length);
> -  a->ram_out(a, &RAM->ReqId, this->Id);
> -  a->ram_out(a, &RAM->ReqCh, this->ReqCh);
> -        /* if it's a specific request (no ASSIGN) ...                */
> -  if(this->Id &0x1f) {
> -        /* if buffers are left in the list of data buffers do       */
> -        /* chaining (LL_MDATA, N_MDATA)                             */
> -    this->More++;
> -    if(i<this->XNum && this->MInd) {
> -      a->ram_out(a, &RAM->Req, this->MInd);
> -      more = TRUE;
> -    }
> -    else {
> -      this->More |=XMOREF;
> -      a->ram_out(a, &RAM->Req, this->Req);
> -      more = FALSE;
> -      if (a->FlowControlIdTable[this->ReqCh] == this->Id)
> -        a->FlowControlSkipTable[this->ReqCh] = TRUE;
> -      /*
> -         Note that remove request was sent to the card
> -         */
> -      if (this->Req == REMOVE) {
> -        a->misc_flags_table[e_no] |= DIVA_MISC_FLAGS_REMOVE_PENDING;
> -      }
> -    }
> -    if(more) {
> -      req_queue(a,this->No);
> -    }
> -  }
> -        /* else it's a ASSIGN                                       */
> -  else {
> -        /* save the request code used for buffer chaining           */
> -    this->MInd = 0;
> -    if (this->Id==BLLC_ID) this->MInd = LL_MDATA;
> -    if (this->Id==NL_ID   ||
> -        this->Id==TASK_ID ||
> -        this->Id==MAN_ID
> -      ) this->MInd = N_MDATA;
> -        /* send the ASSIGN                                          */
> -    this->More |=XMOREF;
> -    a->ram_out(a, &RAM->Req, this->Req);
> -        /* save the reference of the ASSIGN                         */
> -    assign_queue(a, this->No, 0);
> -  }
> -        /* if it is a 'unreturncoded' UREMOVE request, remove the  */
> -        /* Id from our table after sending the request             */
> -  if(this->Req==UREMOVE && this->Id) {
> -    Id = this->Id;
> -    e_no = a->IdTable[Id];
> -    free_entity(a, e_no);
> -    for (i = 0; i < 256; i++)
> -    {
> -      if (a->FlowControlIdTable[i] == Id)
> -        a->FlowControlIdTable[i] = 0;
> -    }
> -    a->IdTable[Id] = 0;
> -    this->Id = 0;
> -  }
> -}
> -static byte scom_ready(ADAPTER * a)
> -{
> -  if(a->ram_in(a, &RAM->Req)) {
> -    if(!a->ReadyInt) {
> -      a->ram_inc(a, &RAM->ReadyInt);
> -      a->ReadyInt++;
> -    }
> -    return 0;
> -  }
> -  return 1;
> -}
> -/*------------------------------------------------------------------*/
> -/* isdn interrupt handler                                           */
> -/*------------------------------------------------------------------*/
> -byte scom_dpc(ADAPTER * a)
> -{
> -  byte c;
> -        /* if a return code is available ...                        */
> -  if(a->ram_in(a, &RAM->Rc)) {
> -        /* call return code handler, if it is not our return code   */
> -        /* the handler returns 2, if it's the return code to an     */
> -        /* ASSIGN the handler returns 1                             */
> -    c = isdn_rc(a,
> -                a->ram_in(a, &RAM->Rc),
> -                a->ram_in(a, &RAM->RcId),
> -                a->ram_in(a, &RAM->RcCh),
> -                0,
> -                /*
> -                  Scom Card does not provide extended information
> -                  */
> -                0, 0);
> -    switch(c) {
> -    case 0:
> -      a->ram_out(a, &RAM->Rc, 0);
> -      break;
> -    case 1:
> -      a->ram_out(a, &RAM->Req, 0);
> -      a->ram_out(a, &RAM->Rc, 0);
> -      break;
> -    case 2:
> -      return TRUE;
> -    }
> -        /* call output function                                     */
> -    scom_out(a);
> -  }
> -  else {
> -        /* if an indications is available ...                       */
> -    if(a->ram_in(a, &RAM->Ind)) {
> -        /* call indication handler, a return value of 2 means chain */
> -        /* a return value of 1 means RNR                            */
> -      c = isdn_ind(a,
> -                   a->ram_in(a, &RAM->Ind),
> -                   a->ram_in(a, &RAM->IndId),
> -                   a->ram_in(a, &RAM->IndCh),
> -                   &RAM->RBuffer,
> -                   a->ram_in(a, &RAM->MInd),
> -                   a->ram_inw(a, &RAM->MLength));
> -      switch(c) {
> -      case 0:
> -        a->ram_out(a, &RAM->Ind, 0);
> -        break;
> -      case 1:
> -        dtrc(dprintf("RNR"));
> -        a->ram_out(a, &RAM->RNR, TRUE);
> -        break;
> -      case 2:
> -        return TRUE;
> -      }
> -    }
> -  }
> -  return FALSE;
> -}
>  byte scom_test_int(ADAPTER * a)
>  {
>    return a->ram_in(a,(void *)0x3fe);
> @@ -539,11 +349,6 @@
>  {
>    a->ram_out(a,(void *)0x3fe,0);
>  }
> -void quadro_clear_int(ADAPTER * a)
> -{
> -  a->ram_out(a,(void *)0x3fe,0);
> -  a->ram_out(a,(void *)0x401,0);
> -}
>  /*------------------------------------------------------------------*/
>  /* return code handler                                              */
>  /*------------------------------------------------------------------*/
> @@ -918,11 +723,11 @@
>     This function works in the same way as xlog on the
>     active board
>     ----------------------------------------------------------- */
> -void xdi_xlog (byte *msg, word code, int length) {
>  #if defined(XDI_USE_XLOG)
> +static void xdi_xlog (byte *msg, word code, int length) {
>    xdi_dbg_xlog ("\x00\x02", msg, code, length);
> -#endif
>  }
> +#endif
>  /* -----------------------------------------------------------
>      This function writes the information about the Return Code
>      processing in the trace buffer. Trace ID is 221.
> --- linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/diva_didd.c.old	2005-02-05 17:44:33.000000000 +0100
> +++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/diva_didd.c	2005-02-05 17:44:44.000000000 +0100
> @@ -140,7 +140,7 @@
>  	return (ret);
>  }
>  
> -void DIVA_EXIT_FUNCTION divadidd_exit(void)
> +static void DIVA_EXIT_FUNCTION divadidd_exit(void)
>  {
>  	diddfunc_finit();
>  	remove_proc();
> --- linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/divamnt.c.old	2005-02-05 17:46:11.000000000 +0100
> +++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/divamnt.c	2005-02-05 17:46:39.000000000 +0100
> @@ -34,9 +34,9 @@
>  MODULE_SUPPORTED_DEVICE("DIVA card driver");
>  MODULE_LICENSE("GPL");
>  
> -int buffer_length = 128;
> +static int buffer_length = 128;
>  module_param(buffer_length, int, 0);
> -unsigned long diva_dbg_mem = 0;
> +static unsigned long diva_dbg_mem = 0;
>  module_param(diva_dbg_mem, ulong, 0);
>  
>  static char *DRIVERNAME =
> --- linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/io.h.old	2005-02-05 17:48:48.000000000 +0100
> +++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/io.h	2005-02-05 17:48:57.000000000 +0100
> @@ -252,11 +252,6 @@
>  #define PR_RAM  ((struct pr_ram *)0)
>  #define RAM ((struct dual *)0)
>  /* ---------------------------------------------------------------------
> -  Functions for port io
> -   --------------------------------------------------------------------- */
> -void outp_words_from_buffer (word __iomem * adr, byte* P, dword len);
> -void inp_words_to_buffer    (word __iomem * adr, byte* P, dword len);
> -/* ---------------------------------------------------------------------
>    platform specific conversions
>     --------------------------------------------------------------------- */
>  extern void * PTR_P(ADAPTER * a, ENTITY * e, void * P);
> --- linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/io.c.old	2005-02-05 17:47:57.000000000 +0100
> +++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/io.c	2005-02-05 17:59:10.000000000 +0100
> @@ -36,7 +36,7 @@
>  extern ADAPTER * adapter[MAX_ADAPTER];
>  extern PISDN_ADAPTER IoAdapters[MAX_ADAPTER];
>  void request (PISDN_ADAPTER, ENTITY *);
> -void pcm_req (PISDN_ADAPTER, ENTITY *);
> +static void pcm_req (PISDN_ADAPTER, ENTITY *);
>  /* --------------------------------------------------------------------------
>    local functions
>    -------------------------------------------------------------------------- */
> @@ -118,7 +118,8 @@
>            &IoAdapter->Name[0]))
>  }
>  /*****************************************************************************/
> -char *(ExceptionCauseTable[]) =
> +#if !defined(DIVA_NO_DEBUGLIB)
> +static char *(ExceptionCauseTable[]) =
>  {
>   "Interrupt",
>   "TLB mod /IBOUND",
> @@ -153,6 +154,8 @@
>   "Reserved 30",
>   "VCED"
>  } ;
> +#endif
> +
>  void
>  dump_trap_frame (PISDN_ADAPTER IoAdapter, byte __iomem *exceptionFrame)
>  {
> @@ -496,7 +499,7 @@
>  /* --------------------------------------------------------------------------
>    XLOG interface
>    -------------------------------------------------------------------------- */
> -void
> +static void
>  pcm_req (PISDN_ADAPTER IoAdapter, ENTITY *e)
>  {
>   diva_os_spin_lock_magic_t OldIrql ;
> @@ -848,26 +851,3 @@
>   if ( e && e->callback )
>    e->callback (e) ;
>  }
> -/* --------------------------------------------------------------------------
> -  routines for aligned reading and writing on RISC
> -  -------------------------------------------------------------------------- */
> -void outp_words_from_buffer (word __iomem * adr, byte* P, dword len)
> -{
> -  dword i = 0;
> -  word w;
> -  while (i < (len & 0xfffffffe)) {
> -    w = P[i++];
> -    w += (P[i++])<<8;
> -    outppw (adr, w);
> -  }
> -}
> -void inp_words_to_buffer (word __iomem * adr, byte* P, dword len)
> -{
> -  dword i = 0;
> -  word w;
> -  while (i < (len & 0xfffffffe)) {
> -    w = inppw (adr);
> -    P[i++] = (byte)(w);
> -    P[i++] = (byte)(w>>8);
> -  }
> -}
> --- linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/message.c.old	2005-02-05 17:49:40.000000000 +0100
> +++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/message.c	2005-02-05 17:57:12.000000000 +0100
> @@ -55,7 +55,7 @@
>  /* and it is not necessary to save it separate for every adapter    */
>  /* Macrose defined here have only local meaning                     */
>  /*------------------------------------------------------------------*/
> -dword diva_xdi_extended_features = 0;
> +static dword diva_xdi_extended_features = 0;
>  
>  #define DIVA_CAPI_USE_CMA                 0x00000001
>  #define DIVA_CAPI_XDI_PROVIDES_SDRAM_BAR  0x00000002
> @@ -72,11 +72,10 @@
>  /* local function prototypes                                        */
>  /*------------------------------------------------------------------*/
>  
> -void group_optimization(DIVA_CAPI_ADAPTER   * a, PLCI   * plci);
> -void set_group_ind_mask (PLCI   *plci);
> -void set_group_ind_mask_bit (PLCI   *plci, word b);
> -void clear_group_ind_mask_bit (PLCI   *plci, word b);
> -byte test_group_ind_mask_bit (PLCI   *plci, word b);
> +static void group_optimization(DIVA_CAPI_ADAPTER   * a, PLCI   * plci);
> +static void set_group_ind_mask (PLCI   *plci);
> +static void clear_group_ind_mask_bit (PLCI   *plci, word b);
> +static byte test_group_ind_mask_bit (PLCI   *plci, word b);
>  void AutomaticLaw(DIVA_CAPI_ADAPTER   *);
>  word CapiRelease(word);
>  word CapiRegister(word);
> @@ -88,7 +87,7 @@
>  word api_remove_start(void);
>  void api_remove_complete(void);
>  
> -void plci_remove(PLCI   *);
> +static void plci_remove(PLCI   *);
>  static void diva_get_extended_adapter_features (DIVA_CAPI_ADAPTER  * a);
>  static void diva_ask_for_xdi_sdram_bar (DIVA_CAPI_ADAPTER  *, IDI_SYNC_REQ  *);
>  
> @@ -100,9 +99,9 @@
>  static void sig_ind(PLCI   *);
>  static void SendInfo(PLCI   *, dword, byte   * *, byte);
>  static void SendSetupInfo(APPL   *, PLCI   *, dword, byte   * *, byte);
> -void SendSSExtInd(APPL   *, PLCI   * plci, dword Id, byte   * * parms);
> +static void SendSSExtInd(APPL   *, PLCI   * plci, dword Id, byte   * * parms);
>  
> -void VSwitchReqInd(PLCI   *plci, dword Id, byte   **parms);
> +static void VSwitchReqInd(PLCI   *plci, dword Id, byte   **parms);
>  
>  static void nl_ind(PLCI   *);
>  
> @@ -254,11 +253,11 @@
>  
>  
>  
> -byte remove_started = FALSE;
> -PLCI dummy_plci;
> +static byte remove_started = FALSE;
> +static PLCI dummy_plci;
>  
>  
> -struct _ftable {
> +static struct _ftable {
>    word command;
>    byte * format;
>    byte (* function)(dword, word, DIVA_CAPI_ADAPTER   *, PLCI   *, APPL   *, API_PARSE *);
> @@ -291,7 +290,7 @@
>    {_MANUFACTURER_I|RESPONSE,            "",             manufacturer_res}
>  };
>  
> -byte * cip_bc[29][2] = {
> +static byte * cip_bc[29][2] = {
>    { "",                     ""                     }, /* 0 */
>    { "\x03\x80\x90\xa3",     "\x03\x80\x90\xa2"     }, /* 1 */
>    { "\x02\x88\x90",         "\x02\x88\x90"         }, /* 2 */
> @@ -324,7 +323,7 @@
>    { "\x02\x88\x90",         "\x02\x88\x90"         }  /* 28 */
>  };
>  
> -byte * cip_hlc[29] = {
> +static byte * cip_hlc[29] = {
>    "",                           /* 0 */
>    "",                           /* 1 */
>    "",                           /* 2 */
> @@ -716,7 +715,7 @@
>  /* internal command queue                                           */
>  /*------------------------------------------------------------------*/
>  
> -void init_internal_command_queue (PLCI   *plci)
> +static void init_internal_command_queue (PLCI   *plci)
>  {
>    word i;
>  
> @@ -729,7 +728,7 @@
>  }
>  
>  
> -void start_internal_command (dword Id, PLCI   *plci, t_std_internal_command command_function)
> +static void start_internal_command (dword Id, PLCI   *plci, t_std_internal_command command_function)
>  {
>    word i;
>  
> @@ -751,7 +750,7 @@
>  }
>  
>  
> -void next_internal_command (dword Id, PLCI   *plci)
> +static void next_internal_command (dword Id, PLCI   *plci)
>  {
>    word i;
>  
> @@ -1048,7 +1047,7 @@
>  }
>  
>  
> -void plci_remove(PLCI   * plci)
> +static void plci_remove(PLCI   * plci)
>  {
>  
>    if(!plci) {
> @@ -1094,7 +1093,7 @@
>  /* Application Group function helpers                               */
>  /*------------------------------------------------------------------*/
>  
> -void set_group_ind_mask (PLCI   *plci)
> +static void set_group_ind_mask (PLCI   *plci)
>  {
>    word i;
>  
> @@ -1102,17 +1101,19 @@
>      plci->group_optimization_mask_table[i] = 0xffffffffL;
>  }
>  
> +#if 0
>  void set_group_ind_mask_bit (PLCI   *plci, word b)
>  {
>    plci->group_optimization_mask_table[b >> 5] |= (1L << (b & 0x1f));
>  }
> +#endif  /*  0  */
>  
> -void clear_group_ind_mask_bit (PLCI   *plci, word b)
> +static void clear_group_ind_mask_bit (PLCI   *plci, word b)
>  {
>    plci->group_optimization_mask_table[b >> 5] &= ~(1L << (b & 0x1f));
>  }
>  
> -byte test_group_ind_mask_bit (PLCI   *plci, word b)
> +static byte test_group_ind_mask_bit (PLCI   *plci, word b)
>  {
>    return ((plci->group_optimization_mask_table[b >> 5] & (1L << (b & 0x1f))) != 0);
>  }
> @@ -1121,7 +1122,7 @@
>  /* c_ind_mask operations for arbitrary MAX_APPL                     */
>  /*------------------------------------------------------------------*/
>  
> -void clear_c_ind_mask (PLCI   *plci)
> +static void clear_c_ind_mask (PLCI   *plci)
>  {
>    word i;
>  
> @@ -1129,7 +1130,7 @@
>      plci->c_ind_mask_table[i] = 0;
>  }
>  
> -byte c_ind_mask_empty (PLCI   *plci)
> +static byte c_ind_mask_empty (PLCI   *plci)
>  {
>    word i;
>  
> @@ -1139,22 +1140,22 @@
>    return (i == C_IND_MASK_DWORDS);
>  }
>  
> -void set_c_ind_mask_bit (PLCI   *plci, word b)
> +static void set_c_ind_mask_bit (PLCI   *plci, word b)
>  {
>    plci->c_ind_mask_table[b >> 5] |= (1L << (b & 0x1f));
>  }
>  
> -void clear_c_ind_mask_bit (PLCI   *plci, word b)
> +static void clear_c_ind_mask_bit (PLCI   *plci, word b)
>  {
>    plci->c_ind_mask_table[b >> 5] &= ~(1L << (b & 0x1f));
>  }
>  
> -byte test_c_ind_mask_bit (PLCI   *plci, word b)
> +static byte test_c_ind_mask_bit (PLCI   *plci, word b)
>  {
>    return ((plci->c_ind_mask_table[b >> 5] & (1L << (b & 0x1f))) != 0);
>  }
>  
> -void dump_c_ind_mask (PLCI   *plci)
> +static void dump_c_ind_mask (PLCI   *plci)
>  {
>  static char hex_digit_table[0x10] =
>    {'0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'};
> @@ -6426,7 +6427,7 @@
>    return iesent;
>  }
>  
> -void SendSSExtInd(APPL   * appl, PLCI   * plci, dword Id, byte   * * parms)
> +static void SendSSExtInd(APPL   * appl, PLCI   * plci, dword Id, byte   * * parms)
>  {
>    word i;
>     /* Format of multi_ssext_parms[i][]:
> @@ -14720,6 +14721,8 @@
>  
>  /*------------------------------------------------------------------*/
>  
> +#if 0
> +
>  /* to be completed */
>  void disable_adapter(byte adapter_number)
>  {
> @@ -14784,6 +14787,7 @@
>    listen_check(a);
>  }
>  
> +#endif  /*  0  */
>  
>  static word CPN_filter_ok(byte   *cpn,DIVA_CAPI_ADAPTER   * a,word offset)
>  {
> @@ -14800,7 +14804,7 @@
>  /* function must be enabled by setting "a->group_optimization_enabled" from the   */
>  /* OS specific part (per adapter).                                                */
>  /**********************************************************************************/
> -void group_optimization(DIVA_CAPI_ADAPTER   * a, PLCI   * plci)
> +static void group_optimization(DIVA_CAPI_ADAPTER   * a, PLCI   * plci)
>  {
>    word i,j,k,busy,group_found;
>    dword info_mask_group[MAX_CIP_TYPES];
> @@ -14967,7 +14971,7 @@
>  
>  /* Functions for virtual Switching e.g. Transfer by join, Conference */
>  
> -void VSwitchReqInd(PLCI   *plci, dword Id, byte   **parms)
> +static void VSwitchReqInd(PLCI   *plci, dword Id, byte   **parms)
>  {
>   word i;
>   /* Format of vswitch_t:
> --- linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/os_4bri.c.old	2005-02-05 17:57:28.000000000 +0100
> +++ linux-2.6.11-rc3-mm1-full/drivers/isdn/hardware/eicon/os_4bri.c	2005-02-05 17:57:50.000000000 +0100
> @@ -17,8 +17,8 @@
>  #include "mi_pc.h"
>  #include "dsrv4bri.h"
>  
> -void *diva_xdiLoadFileFile = NULL;
> -dword diva_xdiLoadFileLength = 0;
> +static void *diva_xdiLoadFileFile = NULL;
> +static dword diva_xdiLoadFileLength = 0;
>  
>  /*
>  **  IMPORTS
> 
