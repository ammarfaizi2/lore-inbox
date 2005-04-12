Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261798AbVDLBBT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261798AbVDLBBT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 21:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVDLBBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 21:01:19 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:19430 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S261798AbVDLBBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 21:01:15 -0400
Subject: Re: [PATCH 1/3] cifs: md5 cleanup - functions
From: Steve French <smfrench@austin.rr.com>
To: Steven French <sfrench@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <OFF8FD24BE.BDEDEA22-ON87256FE0.00741B4F-86256FE0.0074FC27@us.ibm.com>
References: <OFF8FD24BE.BDEDEA22-ON87256FE0.00741B4F-86256FE0.0074FC27@us.ibm.com>
Content-Type: text/plain
Message-Id: <1113267099.5734.1.camel@smfhome.smfdom>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 11 Apr 2005 19:51:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Nyberg <alexn@dsv.su.se> wrote on 04/11/2005 03:26:14 PM:

> > Function names and return types on same line - conform to
established 
> > fs/cifs/ style.
> > 
> > -void
> > -MD5Init(struct MD5Context *ctx)
> > +void MD5Init(struct MD5Context *ctx)
> >  {
> >     ctx->buf[0] = 0x67452301;
> >     ctx->buf[1] = 0xefcdab89;
> > @@ -60,8 +58,7 @@ MD5Init(struct MD5Context *ctx)
> >   * Update context to reflect the concatenation of another buffer
full
> >   * of bytes.
> >   */
> > -void
> > -MD5Update(struct MD5Context *ctx, unsigned char const *buf,
unsigned len)
> > +void MD5Update(struct MD5Context *ctx, unsigned char const *buf, 
> unsigned len)
> >  {
> 
> Can anyone enlighten me why CIFS is not using crypto/md5?
> Same question about md4
> 


There was a patch suggested a year or so ago to remove the older cifs
md5 implementation and have cifsencrypt.c use the newer Linux crypto
API, but since it made the code considerably more complex it did not
make any sense. The current crypto API seems to be designed for much
more complex usage patterns than cifs needs it for. The key use for this
for CIFS is the following small function (to calculate the packet
signitures on cifs packets in fs/cifs/cifsencrypt.c)

38 static int cifs_calculate_signature(const struct smb_hdr * cifs_pdu,
const char * key, char * signature)
39 {
40         struct  MD5Context context;
41 
42         if((cifs_pdu == NULL) || (signature == NULL))
43                 return -EINVAL;
44 
45         MD5Init(&context);
46         MD5Update(&context,key,CIFS_SESSION_KEY_SIZE+16);
47       
MD5Update(&context,cifs_pdu->Protocol,cifs_pdu->smb_buf_length);
48         MD5Final(signature,&context);
49         return 0;
50 }


The problem with moving this function to use crypto/md5.c is that the
three needed md5 functions (MD5Init, MD5Update, MD5Final) are not
exported (although they appear to be already implemented in close to the
right form already - but they are defined as static in crypto/md5.c) and
the only way to do the equivalent is much more complicated. I don't mind
using those equivalent three functions in crypto/md5.c directly if
someone could verify that they match the three functions of the same
name and could export them so cifs could call them - I would like to get
rid of cifs/md5.c

There was a similar issue IIRC with md4.c - the code gets more complex
rather than less complex moving to the crypto API.

