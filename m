Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318740AbSHAMRD>; Thu, 1 Aug 2002 08:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318737AbSHAMQE>; Thu, 1 Aug 2002 08:16:04 -0400
Received: from daimi.au.dk ([130.225.16.1]:27008 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S318740AbSHAMPq>;
	Thu, 1 Aug 2002 08:15:46 -0400
Message-ID: <3D49273C.B11C237D@daimi.au.dk>
Date: Thu, 01 Aug 2002 14:19:08 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: stas.orel@mailcity.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] vm86: Clear AC on INT
References: <3D4419F5.3000104@yahoo.com>
Content-Type: multipart/mixed;
 boundary="------------47C52F29D5223C2431DC8063"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------47C52F29D5223C2431DC8063
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Stas Sergeev wrote:
> 
> Hello.
> 
> According to this:
> http://support.intel.com/design/intarch/techinfo/Pentium/instrefi.htm#89126
> AC flag is cleared by an INT
> instruction executed in real mode.
> The attached patch implements that
> functionality and solves some
> problems recently discussed in
> dosemu mailing list.

Finally I found the old test program I originally used to discover
the missing clear_IF bug. With small modifications it should be
able to verify the existence of this AC bug and that it has been
corrected. I'm going to try this asap.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razrep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
--------------47C52F29D5223C2431DC8063
Content-Type: text/plain; charset=us-ascii;
 name="traptest.pas"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="traptest.pas"


Uses Dos;

Const Code: Array[0..79] Of Byte = (
$89,$e5,$50,$53,$06,$51,$fb,$f4,$cf,$90,$90,$90,$90,$90,$90,$90,
$fb,$f4,$89,$ec,$cf,$90,$90,$90,$90,$90,$90,$90,$90,$90,$90,$90,
$0e,$e8,$02,$00,$89,$ec,$cf,$90,$90,$90,$90,$90,$90,$90,$90,$90,
$cd,$01,$cd,$03,$cd,$08,$cc,$9d,$89,$ec,$cf,$90,$90,$90,$90,$90,
$9c,$fa,$89,$ec,$cf,$90,$90,$90,$90,$90,$90,$90,$90,$90,$90,$90
);

Const FV: Array[0..3] Of Word = ($7002,$7102,$7202,$7302);

Var Buffer: Array[0..40000] Of Char;
Var Index: Word;
Var I: Word;

Procedure BufWrite(S: String);
Var I: Byte;
Begin
     For I:=1 To Length(S) Do Begin
         Buffer[Index]:=S[I];
         Inc(Index);
     End;
End;

Procedure Hex(w : Word);
Const
  HexKarakterer : Array [0..$F] Of Char =
    '0123456789ABCDEF';
Begin
  BufWrite(HexKarakterer[Hi(w) Shr 4]+
           HexKarakterer[Hi(w) And $F]+
           HexKarakterer[Lo(w) Shr 4]+
           HexKarakterer[Lo(w) And $F]+
           ' ');
End;

Procedure MyInt1(Flags, CS, IP, AX, BX, CX, DX, SI, DI, DS, ES, BP: word);
Interrupt;
Begin
     Hex(IP);
     Hex(MemW[CS:IP]);
     Hex(SPtr);
     Hex(Flags);
     BufWrite('Trace'#13#10);
End;

Procedure MyInt3(Flags, CS, IP, AX, BX, CX, DX, SI, DI, DS, ES, BP: word);
Interrupt;
Begin
     Hex(IP);
     Hex(MemW[CS:IP]);
     Hex(SPtr);
     Hex(Flags);
     BufWrite('Break'#13#10);
End;

Procedure MyInt8(Flags, CS, IP, AX, BX, CX, DX, SI, DI, DS, ES, BP: word);
Interrupt;
Begin
     Port[$20]:=$20;
     Hex(IP);
     Hex(MemW[CS:IP]);
     Hex(SPtr);
     Hex(Flags);
     BufWrite('Timer'#13#10);
End;

Var S01,S03,S08,S18: Pointer;
Var X,Y,Z: Byte;
Var Regs: Registers;
Var T: Byte;
Begin
     WriteLn('Waiting');
     Index := 0;
     T:=Mem[$40:$6C];
     Repeat
           InLine($F4);
     Until Byte(Mem[$40:$6C]-T) > 42;
     WriteLn('Runing tests');
     GetIntVec($01,S01);
     GetIntVec($03,S03);
     GetIntVec($08,S08);
     GetIntVec($18,S18);
     SetIntVec($01,@MyInt1);
     SetIntVec($03,@MyInt3);
     SetIntVec($08,@MyInt8);
     SetIntVec($18,@Code);
     For X:=0 To 3 Do
         For Y := 0 To 3 Do
             For Z := 1 To 4 Do
     Begin
          BufWrite('Test'#13#10);
          Regs.AX:=FV[X];
          Regs.BX:=FV[Y];
          Regs.CX:=Ofs(Code[Z*16]);
          Regs.ES:=Seg(Code);
          Regs.Flags:=$7202;
          Intr($18,Regs);
     End;
     SetIntVec($01,S01);
     SetIntVec($03,S03);
     SetIntVec($08,S08);
     SetIntVec($18,S18);
     WriteLn('Printing results');
     For I:=0 To Index-1 Do
         Write(Buffer[I]);
     WriteLn('All done.');
End.

--------------47C52F29D5223C2431DC8063--

