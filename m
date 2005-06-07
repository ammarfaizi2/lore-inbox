Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVFGWAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVFGWAH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 18:00:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVFGWAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 18:00:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:48308 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261997AbVFGV6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 17:58:22 -0400
Date: Tue, 7 Jun 2005 14:59:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christian Leber <christian@leber.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] lzma support: decompression lib, initrd support
Message-Id: <20050607145903.4b2ac9bf.akpm@osdl.org>
In-Reply-To: <20050607213204.GA2645@core.home>
References: <20050607213204.GA2645@core.home>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Leber <christian@leber.de> wrote:
>
> This patch is against 2.6.12-rc6.
> 
> This patch adds the possibility to compress a initrd with lzma, you
> need ths CONFIG_BLK_DEV_RAM_LZMA build option to make use of lzma
> compressed initrds.
> (Device Drivers -> Block devices)
> 
> For example the debian installer initrd:
> -rw-r--r--  1 ijuz ijuz 2870355 Mar  5 20:00 initrd.gz
> -rw-r--r--  1 ijuz ijuz 2158769 May  8 02:09 initrd.lzma
> 

Well that's a nice improvement.

> +	switch (nblocks) {
> +		case CRAMDISK_LZMA :     /* lzma image found */
> +			#ifdef CONFIG_BLK_DEV_RAM_LZMA
> +			if(lzma_load(in_fd, out_fd) == 0)
> +				goto successful_load;
> +			#else
> +			printk(KERN_ALERT "RAMDISK: you don't have CONFIG_BLK_DEV_RAM_LZMA\n");
> +			#endif
> +			break;
> +		case CRAMDISK_GZ :      /* gzip image found */
> +			#ifdef CONFIG_BLK_DEV_RAM_GZ
> +			if(gz_load(in_fd, out_fd) == 0)
> +				goto successful_load;
> +			#else
> +			printk(KERN_ALERT "RAMDISK: you don't have CONFIG_BLK_DEV_RAM_GZ\n");
> +			#endif
> +			break;
> +		default :
> +			break;

Oh gack.  The #ifdefs start in column zero, please.

> +#define _LZMA_IN_CB  // neccessary
> +#define _LZMA_OUT_READ // neccessary

What strange comments.

> +#ifndef UInt32
> +#define UInt32 uint32_t
> +#endif

Kill it.  Use u32 or __u32.

> +#include <../lib/LzmaDecode.h>
> +#include <../lib/LzmaDecode.c>

lower-case filenames please.

> +typedef struct _CBuffer
> +{
> +	ILzmaInCallback InCallback;
> +	unsigned char *Buffer;
> +	int lzma_read_fd;
> +} CBuffer; 

Nuke the StudlyCaps.

> +int LzmaReadCompressed(void *object, unsigned char **buffer, unsigned int *size)

All over the place.

> +{ 
> +	CBuffer *bo = (CBuffer *)object;

Unneeded typecast.

> +	int read_size;
> +	/* try to read _LZMA_READ_COMPRESSED_BUFFER_SIZE bytes */
> +	read_size = sys_read(bo->lzma_read_fd,bo->Buffer,_LZMA_READ_COMPRESSED_BUFFER_SIZE);

Add a single space after the commas and try to fit code into an 80-col
xterm.

> +	UInt32 nowPos, dictionarySize  = 0;
> +	unsigned char *dictionary, *out_buffer=0;

Place a single space before and after the "=".

> +
> +	if(sys_read(in_fd, (unsigned char *)&properties, 5) == 0) {

and after "if"

> +		printk(KERN_ERR "RAMDISK: ran out of compressed data");

newline?

> +		return -1;
> +	}
> +
> +	outSize = 0;
> +	for (i_for = 0; i_for < 4; i_for++) {

"i"

> +		unsigned char b;
> +		if(sys_read(in_fd, &b, sizeof(b)) == 0) {

"if ("

> +			printk(KERN_ERR "RAMDISK: ran out of compressed data");

newline?

> +	for (i_for = 0; i_for < 4; i_for++) {
> +		unsigned char b;
> +		if(sys_read(in_fd, &b, sizeof(b)) == 0) {

etc...

> +	for (pb = 0; prop0 >= (9 * 5); pb++, prop0 -= (9 * 5));
> +	for (lp = 0; prop0 >= 9; lp++, prop0 -= 9);

Put the ";" on a line of its own.

I'd have thought the above could be done arithmetically?

> +	lc = prop0;
> +
> +	lzmaInternalSize = (LZMA_BASE_SIZE + (LZMA_LIT_SIZE << (lc + lp)))* sizeof(CProb);

One space before and after the multiplication symbol.

80-cols.

> +	lzmaInternalSize += 100; // because we are using _LZMA_OUT_READ
> +	
> +	lzmaInternalData = kmalloc(lzmaInternalSize, GFP_KERNEL);
> +	if(lzmaInternalData == 0) { 
> +		printk(KERN_ERR "RAMDISK: failed to get space for lzmaInternalData");
> +		return -1;
> +	}
> +
> +	bo.InCallback.Read = LzmaReadCompressed;
> +	bo.lzma_read_fd = in_fd;
> +	bo.Buffer = kmalloc(_LZMA_READ_COMPRESSED_BUFFER_SIZE, GFP_KERNEL);
> +	if(bo.Buffer == 0) { 

"if (".

This patch adds trailing whitespace.

> +		printk(KERN_ERR "RAMDISK: failed to get space for bo.Buffer");
> +		return -1;

It just leaked `lzmaInternalData'.

> +	}
> +
> +	for (i_for = 0; i_for < 4; i_for++)
> +		dictionarySize += (UInt32)(properties[1 + i_for]) << (i_for * 8);

Is the cast needed?

> +	if (dictionarySize == 0)
> +		dictionarySize = 1; /* LZMA decoder can not work with dictionarySize = 0 */
> +	dictionary = (unsigned char *)vmalloc(dictionarySize);

vmalloc() returns void*

> +	if(dictionary == 0) { 
> +		printk(KERN_ERR "RAMDISK: failed to get space for dictionary");
> +		return -1;
> +	}
> +	res = LzmaDecoderInit((unsigned char *)lzmaInternalData, lzmaInternalSize,
> +		lc, lp, pb,
> +		dictionary, dictionarySize,
> +		&bo.InCallback);
> +
> +	if (res == 0)
> +	for (nowPos = 0; nowPos < outSize;) {

Broken indenting.

> +		out_buffer = kmalloc(_LZMA_WRITE_BUFFER_SIZE,GFP_KERNEL);
> +		if(out_buffer == 0) { 
> +			printk(KERN_ERR "RAMDISK: failed to get space for out_buffer");
> +			return -1;
> +		}

More leaking.

> +		
> +		res = LzmaDecode((unsigned char *)lzmaInternalData,
> +			out_buffer, _LZMA_WRITE_BUFFER_SIZE, &outSizeProcessed);
> +		if (res != 0)
> +			break;
> +		if (outSizeProcessed == 0) {
> +			outSize = nowPos;
> +			break;
> +		}
> +		nowPos += outSizeProcessed;
> +		res = sys_write(out_fd,out_buffer,outSizeProcessed);
> +		if(res!=outSizeProcessed) {
> +			printk(KERN_ERR "can't write everything");
> +		}

Unneeded braces.

> --- linux-2.6.12-rc6.orig/lib/LzmaDecode.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.12-rc6/lib/LzmaDecode.c	2005-06-07 21:33:34.000000000 +0200
> ...
> +
> +#define RC_INIT2 Code = 0; Range = 0xFFFFFFFF; \
> +  { int i; for(i = 0; i < 5; i++) { RC_TEST; Code = (Code << 8) | RC_READ_BYTE; }}
> ...
> +
> +#define RC_TEST { if (Buffer == BufferLim) \
> +  { UInt32 size; int result = InCallback->Read(InCallback, &Buffer, &size); if (result != LZMA_RESULT_OK) return result; \
> +  BufferLim = Buffer + size; if (size == 0) return LZMA_RESULT_DATA_ERROR; }}
> +
> +#define RC_INIT Buffer = BufferLim = 0; RC_INIT2
> +
> +#else
> +
> +#define RC_TEST { if (Buffer == BufferLim) return LZMA_RESULT_DATA_ERROR; }
> +
> +#define RC_INIT(buffer, bufferSize) Buffer = buffer; BufferLim = buffer + bufferSize; RC_INIT2
> + 
> +#endif
> +
> +#define RC_NORMALIZE if (Range < kTopValue) { RC_TEST; Range <<= 8; Code = (Code << 8) | RC_READ_BYTE; }
> +
> +#define IfBit0(p) RC_NORMALIZE; bound = (Range >> kNumBitModelTotalBits) * *(p); if (Code < bound)
> +#define UpdateBit0(p) Range = bound; *(p) += (kBitModelTotal - *(p)) >> kNumMoveBits;
> +#define UpdateBit1(p) Range -= bound; Code -= bound; *(p) -= (*(p)) >> kNumMoveBits;
> +
> +#define RC_GET_BIT2(p, mi, A0, A1) IfBit0(p) \
> +  { UpdateBit0(p); mi <<= 1; A0; } else \
> +  { UpdateBit1(p); mi = (mi + mi) + 1; A1; } 
> +  
> +#define RC_GET_BIT(p, mi) RC_GET_BIT2(p, mi, ; , ;)               
> +
> +#define RangeDecoderBitTreeDecode(probs, numLevels, res) \
> +  { int i = numLevels; res = 1; \
> +  do { CProb *p = probs + res; RC_GET_BIT(p, res) } while(--i != 0); \
> +  res -= (1 << numLevels); }

Ugh.  Can we remove all this macro magic?

> +
> +#define kNumPosBitsMax 4
> +#define kNumPosStatesMax (1 << kNumPosBitsMax)
> +
> +#define kLenNumLowBits 3
> +#define kLenNumLowSymbols (1 << kLenNumLowBits)
> +#define kLenNumMidBits 3
> +#define kLenNumMidSymbols (1 << kLenNumMidBits)
> +#define kLenNumHighBits 8
> +#define kLenNumHighSymbols (1 << kLenNumHighBits)
> +
> +#define LenChoice 0
> +#define LenChoice2 (LenChoice + 1)
> +#define LenLow (LenChoice2 + 1)
> +#define LenMid (LenLow + (kNumPosStatesMax << kLenNumLowBits))
> +#define LenHigh (LenMid + (kNumPosStatesMax << kLenNumMidBits))
> +#define kNumLenProbs (LenHigh + kLenNumHighSymbols) 
> +
> +
> +#define kNumStates 12
> +#define kNumLitStates 7
> +
> +#define kStartPosModelIndex 4
> +#define kEndPosModelIndex 14
> +#define kNumFullDistances (1 << (kEndPosModelIndex >> 1))
> +
> +#define kNumPosSlotBits 6
> +#define kNumLenToPosStates 4
> +
> +#define kNumAlignBits 4
> +#define kAlignTableSize (1 << kNumAlignBits)
> +
> +#define kMatchMinLen 2
> +
> +#define IsMatch 0
> +#define IsRep (IsMatch + (kNumStates << kNumPosBitsMax))
> +#define IsRepG0 (IsRep + kNumStates)
> +#define IsRepG1 (IsRepG0 + kNumStates)
> +#define IsRepG2 (IsRepG1 + kNumStates)
> +#define IsRep0Long (IsRepG2 + kNumStates)
> +#define PosSlot (IsRep0Long + (kNumStates << kNumPosBitsMax))
> +#define SpecPos (PosSlot + (kNumLenToPosStates << kNumPosSlotBits))
> +#define Align (SpecPos + kNumFullDistances - kEndPosModelIndex)
> +#define LenCoder (Align + kAlignTableSize)
> +#define RepLenCoder (LenCoder + kNumLenProbs)
> +#define Literal (RepLenCoder + kNumLenProbs)

And this?

> +#if Literal != LZMA_BASE_SIZE
> +StopCompilingDueBUG
> +#endif

eh?

> +#ifdef _LZMA_OUT_READ
> +
> +typedef struct _LzmaVarState
> +{
> +  Byte *Buffer;
> +  Byte *BufferLim;
> +  UInt32 Range;
> +  UInt32 Code;
> +  #ifdef _LZMA_IN_CB
> +  ILzmaInCallback *InCallback;
> +  #endif
> +  Byte *Dictionary;
> +  UInt32 DictionarySize;
> +  UInt32 DictionaryPos;
> +  UInt32 GlobalPos;
> +  UInt32 Reps[4];
> +  int lc;
> +  int lp;
> +  int pb;
> +  int State;
> +  int RemainLen;
> +  Byte TempDictionary[4];
> +} LzmaVarState;
> +
> +int LzmaDecoderInit(
> +    unsigned char *buffer, UInt32 bufferSize,
> +    int lc, int lp, int pb,
> +    unsigned char *dictionary, UInt32 dictionarySize,
> +    #ifdef _LZMA_IN_CB
> +    ILzmaInCallback *InCallback
> +    #else
> +    unsigned char *inStream, UInt32 inSize
> +    #endif
> +    )

My eyes!

> +{
> +  Byte *Buffer;
> +  Byte *BufferLim;
> +  UInt32 Range;
> +  UInt32 Code;
> +  LzmaVarState *vs = (LzmaVarState *)buffer;
> +  CProb *p = (CProb *)(buffer + sizeof(LzmaVarState));
> +  UInt32 numProbs = Literal + ((UInt32)LZMA_LIT_SIZE << (lc + lp));
> +  UInt32 i;
> +  if (bufferSize < numProbs * sizeof(CProb) + sizeof(LzmaVarState))
> +    return LZMA_RESULT_NOT_ENOUGH_MEM;
> +  vs->Dictionary = dictionary;
> +  vs->DictionarySize = dictionarySize;
> +  vs->DictionaryPos = 0;
> +  vs->GlobalPos = 0;
> +  vs->Reps[0] = vs->Reps[1] = vs->Reps[2] = vs->Reps[3] = 1;
> +  vs->lc = lc;
> +  vs->lp = lp;
> +  vs->pb = pb;
> +  vs->State = 0;
> +  vs->RemainLen = 0;
> +  dictionary[dictionarySize - 1] = 0;
> +  for (i = 0; i < numProbs; i++)
> +    p[i] = kBitModelTotal >> 1; 
> +
> +  #ifdef _LZMA_IN_CB
> +  RC_INIT;
> +  #else
> +  RC_INIT(inStream, inSize);
> +  #endif
> +  vs->Buffer = Buffer;
> +  vs->BufferLim = BufferLim;
> +  vs->Range = Range;
> +  vs->Code = Code;
> +  #ifdef _LZMA_IN_CB
> +  vs->InCallback = InCallback;
> +  #endif
> +
> +  return LZMA_RESULT_OK;
> +}

Dude.  I ain't putting stuff like that in our kernel!

> +int LzmaDecode(unsigned char *buffer, 
> +    unsigned char *outStream, UInt32 outSize,
> +    UInt32 *outSizeProcessed)
> +{
> +  LzmaVarState *vs = (LzmaVarState *)buffer;
> +  Byte *Buffer = vs->Buffer;
> +  Byte *BufferLim = vs->BufferLim;
> +  UInt32 Range = vs->Range;
> +  UInt32 Code = vs->Code;
> +  #ifdef _LZMA_IN_CB
> +  ILzmaInCallback *InCallback = vs->InCallback;
> +  #endif
> +  CProb *p = (CProb *)(buffer + sizeof(LzmaVarState));
> +  int state = vs->State;
> +  Byte previousByte;
> +  UInt32 rep0 = vs->Reps[0], rep1 = vs->Reps[1], rep2 = vs->Reps[2], rep3 = vs->Reps[3];
> +  UInt32 nowPos = 0;
> +  UInt32 posStateMask = (1 << (vs->pb)) - 1;
> +  UInt32 literalPosMask = (1 << (vs->lp)) - 1;
> +  int lc = vs->lc;
> +  int len = vs->RemainLen;
> +  UInt32 globalPos = vs->GlobalPos;

Sigh.  I can see an argument for keeping the in-kernel code in sync with
Igor's upstream code, but this is lunch-losing stuff :(


