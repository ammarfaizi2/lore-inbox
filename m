Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129144AbQJZRiD>; Thu, 26 Oct 2000 13:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129177AbQJZRhx>; Thu, 26 Oct 2000 13:37:53 -0400
Received: from chiark.greenend.org.uk ([195.224.76.132]:48398 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id <S129144AbQJZRhp>; Thu, 26 Oct 2000 13:37:45 -0400
From: Ian Jackson <ijackson@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14840.27617.448792.438567@chiark.greenend.org.uk>
Date: Thu, 26 Oct 2000 18:37:37 +0100 (BST)
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux 2.2.18pre17 + VM-global -7 = `Negative d_count' oops
Newsgroups: chiark.mail.linux-rutgers.kernel
In-Reply-To: <20001025050631.A6817@athlon.random>
In-Reply-To: <39F4AB91.72F2C300@transmeta.com>
	<20001025050631.A6817@athlon.random>
X-Mailer: VM 6.75 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes ("Re: linux 2.2.18-pre17: "Kernel panic: LRU list corrupted""):
> I also included the fix in a new VM-global patch against vanilla 2.2.18pre17
> (the VM-global patch is available as a single patch inside 2.2.18pre17aa1/
> directory too but I have to maintain a separate version of it against clean
> 2.2.18pre17 due silly rejects that I can't avoid)
> 
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.2/2.2.18pre17/VM-global-2.2.18pre17-7.bz2

I've been having apparently VM-related `pauses' with 2.2.17 [1], so I
thought I'd try 2.2.18pre17 with that patch.  The results weren't
good: I get many instances of

 Negative d_count (-805538369) for [binary garbage]/<NULL>

followed by an oops.  Kernel logfile extract below, uuencoded.

I'm sure I'd be able to reproduce this, but I'd rather not because
this is a production system.  ver_linux reports:

chiark:linux-2.2.17-chiark> sh scripts/ver_linux
-- Versions installed: (if some fields are empty or looks
-- unusual then possibly you have very old versions)
Linux chiark 2.2.17 #2 Thu Oct 26 10:57:45 BST 2000 i586 unknown
Kernel modules         2.3.11
Gnu C                  2.95.2
Binutils               2.9.5.0.37
Linux C Library        2.1.3
Dynamic linker         ldd: version 1.9.11
Procps                 2.0.6
Mount                  2.10f
Net-tools              2.05
Kbd                    0.99
Sh-utils               2.0
cat: /proc/modules: No such file or directory
Modules Loaded
chiark:linux-2.2.17-chiark>

I don't know why it says `Kernel modules 2.3.11', since I have
disabled kernel modules completely.  My CPU is:

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 5
model           : 8
model name      : AMD-K6(tm) 3D processor
stepping        : 0
cpu MHz         : 350.808
cache size      : 64 KB
fdiv_bug        : no
hlt_bug         : no
sep_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr mce cx8 sep mmx 3dnow
bogomips        : 699.60

REPORTING-BUGS wanted me to include /proc/scsi/scsi, so here it is:

Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DCAS-34330       Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: IBM      Model: DCAS-34330       Rev: S65A
  Type:   Direct-Access                    ANSI SCSI revision: 02
Host: scsi0 Channel: 00 Id: 04 Lun: 00
  Vendor: HP       Model: T20              Rev: 3.01
  Type:   Sequential-Access                ANSI SCSI revision: 02
Host: scsi1 Channel: 00 Id: 00 Lun: 00
  Vendor: IBM      Model: DNES-318350W     Rev: SA30
  Type:   Direct-Access                    ANSI SCSI revision: 03

It might be relevant that a large part of the system's job is to be a
shell account server, and users log in with a variety of mechanisms,
most often OpenSSH (Debian 1.2.3-9).  I've not had any reports from
users about sessions randomly dropping, which I might have expected;
however, I did have a number of background cron jobs die in very
strange ways suggesting killing of processes at random.

The system as a whole is largely Debian 2.2, and has 256Mb of RAM and
about 400Mb of swap.  It usually runs with about 50-100Mb of swap used
and at a load of somewhere around 1ish during busy periods.


[1] VM lockup problem:

I believe that this is a known problem with the 2.2.x VM ?  The
symptoms I have are that under reasonably high but not excessive VM
and/or disk load, the system will freeze for around 10-15 minutes.
Most often this seems to have beeen provoked by a moderately large
(20Mb or so) Emacs doing an auto-save during an otherwise-busy time.

During the lockup network packets are processed - pings receive
replies, and TCP connection attempts succeed, but there is no evidence
of any user-mode executing.  After the lockup the system apparently
just resumes where it left off.  Sometimes afterwards there is a
message like `VM: do_try_to_free_pages failed for emacs...' but more
often there isn't.


Thanks for your attention,

Ian.

begin 664 chiark-oops
M3V-T(#(U(#$U.C`U.C`U(&-H:6%R:R!K97)N96PZ($%D9&EN9R!3=V%P.B`T
M,#DU.3)K('-W87`M<W!A8V4@*'!R:6]R:71Y(#$P*0I/8W0@,C4@,3<Z,S8Z
M,S,@8VAI87)K(&ME<FYE;#H@3F5G871I=F4@9%]C;W5N="`H+3@P-34S.#,V
M.2D@9F]R(%PR,3-$)%Y$7#(P,\!>5#E$)%Y0=5Y#,<##N./____#7#(Q,?9<
M,C$S1"1>1%PR,#/`7E0Y1"1>4'5>1[C[____PUPR,C"XX____\-<,C$Q]KA=
M7D$O/$Y53$P^"D]C="`R-2`Q-SHS-CHS,R!C:&EA<FL@:V5R;F5L.B!5;F%B
M;&4@=&\@:&%N9&QE(&ME<FYE;"!.54Q,('!O:6YT97(@9&5R969E<F5N8V4@
M870@=FER='5A;"!A9&1R97-S(#`P,#`P,#`P"D]C="`R-2`Q-SHS-CHS,R!C
M:&EA<FL@:V5R;F5L.B!C=7)R96YT+3YT<W,N8W(S(#T@,#8S,F(P,#`L("4E
M8W(S(#T@,#8S,F(P,#`*3V-T(#(U(#$W.C,V.C,S(&-H:6%R:R!K97)N96PZ
M("IP9&4@/2`P,#`P,#`P,`I/8W0@,C4@,3<Z,S8Z,S,@8VAI87)K(&ME<FYE
M;#H@3V]P<SH@,#`P,@I/8W0@,C4@,3<Z,S8Z,S,@8VAI87)K(&ME<FYE;#H@
M0U!5.B`@("`P"D]C="`R-2`Q-SHS-CHS,R!C:&EA<FL@:V5R;F5L.B!%25`Z
M("`@(#`P,3`Z6V1P=70K,S$P+S,R.%T*3V-T(#(U(#$W.C,V.C,S(&-H:6%R
M:R!K97)N96PZ($5&3$%'4SH@,#`P,3`R.38*3V-T(#(U(#$W.C,V.C,S(&-H
M:6%R:R!K97)N96PZ(&5A>#H@,#`P,#`P-C0@("!E8G@Z(&-F9F,W,#(P("`@
M96-X.B!C86-C8S`P,"`@(&5D>#H@,#`P,#`P,68*3V-T(#(U(#$W.C,V.C,S
M(&-H:6%R:R!K97)N96PZ(&5S:3H@8V9F8S<U8F8@("!E9&DZ(&-F9F,W,#(P
M("`@96)P.B`P,#`P,#`P,"`@(&5S<#H@8V%C8V1C8V,*3V-T(#(U(#$W.C,V
M.C,S(&-H:6%R:R!K97)N96PZ(&1S.B`P,#$X("`@97,Z(#`P,3@@("!S<SH@
M,#`Q.`I/8W0@,C4@,3<Z,S8Z,S,@8VAI87)K(&ME<FYE;#H@4')O8V5S<R!E
M>'!R("AP:60Z(#$X-S`V+"!P<F]C97-S(&YR.B`S,C`L('-T86-K<&%G93UC
M86-C9#`P,"D*3V-T(#(U(#$W.C,V.C,S(&-H:6%R:R!K97)N96PZ(%-T86-K
M.B!C,#$X,S=D,"`P,#`P,#`P,"!C,V1C9#@Q8R!C9F9C.3$V,"!C,#$R,6(S
M82!C9F9C-S`R,"!C,V1C9#@Q8R`P.#`T8C`P,"`*3V-T(#(U(#$W.C,V.C,S
M(&-H:6%R:R!K97)N96PZ("`@("`@("!C,#`P,#`P,"!C,#$R,F,W-R!C,V1C
M9#@Q8R!C,V1C9#@Q8R!C8C$Y,#EC,"!C,#$S,#0R.2!C,V1C9#@Q8R!C,#%D
M868W."`*3V-T(#(U(#$W.C,V.C,S(&-H:6%R:R!K97)N96PZ("`@("`@("!F
M9F9F9F9F."!C86-C8S`P,"!C86-C9&4V."!C,#$Q83`R,"!C9&,U,&1E8R`P
M,#`P,#`X,"!C86-C9&4V."`P,#`Q9F1D-R`*3V-T(#(U(#$W.C,V.C,S(&-H
M:6%R:R!K97)N96PZ($-A;&P@5')A8V4Z(%MH=6YG7W5P7W1T>5]R96%D*S`O
M,C1=(%M?7V9P=70K-C(O-S)=(%MF<'5T*S(S+S<R72!;;&]A9%]E;&9?8FEN
M87)Y*S$Y,S,O,CDW,ET@6V1O7V=E;F5R:6-?9FEL95]R96%D*S$T.3(O,34P
M-%T@6W)E861?97AE8RLS-C,O,S@P72!;<V5A<F-H7V)I;F%R>5]H86YD;&5R
M*S<Q+S$X.%T@"D]C="`R-2`Q-SHS-CHS,R!C:&EA<FL@:V5R;F5L.B`@("`@
M("`@6V1O7V5X96-V92LT,C4O-#DR72!;<WES7V5X96-V92LT-R\Y,ET@6W-Y
M<W1E;5]C86QL*S4R+S4V72`*3V-T(#(U(#$W.C,V.C,S(&-H:6%R:R!K97)N
M96PZ($-O9&4Z(&,W(#`U(#`P(#`P(#`P(#`P(#`P(#`P(#`P(#`P(#@S(&,T
M(#$P(#5B(#5E(&,S(#@Y(&8V(#4S(#AB(`I/8W0@,C4@,3@Z,#<Z,#<@8VAI
M87)K(&ME<FYE;#H@3F5G871I=F4@9%]C;W5N="`H+3@P-34S.#,V.2D@9F]R
M(%PR,3-$)%Y$7#(P,\!>5#E$)%Y0=5Y#,<##N./____#7#(Q,?9<,C$S1"1>
M1%PR,#/`7E0Y1"1>4'5>1[C[____PUPR,C"XX____\-<,C$Q]KA=7D$O/$Y5
M3$P^"D]C="`R-2`Q.#HP-SHP-R!C:&EA<FL@:V5R;F5L.B!5;F%B;&4@=&\@
M:&%N9&QE(&ME<FYE;"!.54Q,('!O:6YT97(@9&5R969E<F5N8V4@870@=FER
M='5A;"!A9&1R97-S(#`P,#`P,#`P"D]C="`R-2`Q.#HP-SHP-R!C:&EA<FL@
M:V5R;F5L.B!C=7)R96YT+3YT<W,N8W(S(#T@,#5F-3$P,#`L("4E8W(S(#T@
M,#5F-3$P,#`*3V-T(#(U(#$X.C`W.C`W(&-H:6%R:R!K97)N96PZ("IP9&4@
M/2`P,#`P,#`P,`I/8W0@,C4@,3@Z,#<Z,#<@8VAI87)K(&ME<FYE;#H@3V]P
M<SH@,#`P,@I/8W0@,C4@,3@Z,#<Z,#<@8VAI87)K(&ME<FYE;#H@0U!5.B`@
M("`P"D]C="`R-2`Q.#HP-SHP-R!C:&EA<FL@:V5R;F5L.B!%25`Z("`@(#`P
M,3`Z6V1P=70K,S$P+S,R.%T*3V-T(#(U(#$X.C`W.C`W(&-H:6%R:R!K97)N
M96PZ($5&3$%'4SH@,#`P,3`R.38*3V-T(#(U(#$X.C`W.C`W(&-H:6%R:R!K
M97)N96PZ(&5A>#H@,#`P,#`P-C0@("!E8G@Z(&-F9F,W,#(P("`@96-X.B!C
M-61E93`P,"`@(&5D>#H@,#`P,#`P,38*3V-T(#(U(#$X.C`W.C`W(&-H:6%R
M:R!K97)N96PZ(&5S:3H@8V9F8S<U8F8@("!E9&DZ(&-F9F,W,#(P("`@96)P
M.B`P,#`P,#`P,"`@(&5S<#H@8S5D969C8V,*3V-T(#(U(#$X.C`W.C`W(&-H
M:6%R:R!K97)N96PZ(&1S.B`P,#$X("`@97,Z(#`P,3@@("!S<SH@,#`Q.`I/
M8W0@,C4@,3@Z,#<Z,#<@8VAI87)K(&ME<FYE;#H@4')O8V5S<R!E>'!R("AP
M:60Z(#(S,C8P+"!P<F]C97-S(&YR.B`Q-CDL('-T86-K<&%G93UC-61E9C`P
M,"D*3V-T(#(U(#$X.C`W.C`W(&-H:6%R:R!K97)N96PZ(%-T86-K.B!C,#$X
M,S=D,"`P,#`P,#`P,"!C8S4V93=D8R!C9F9C.3$V,"!C,#$R,6(S82!C9F9C
M-S`R,"!C8S4V93=D8R`P.#`T8C`P,"`*3V-T(#(U(#$X.C`W.C`W(&-H:6%R
M:R!K97)N96PZ("`@("`@("!C,#`P,#`P,"!C,#$R,F,W-R!C8S4V93=D8R!C
M8S4V93=D8R!C9F9E9#AC,"!C,#$S,#0R.2!C8S4V93=D8R!C,#%D868W."`*
M3V-T(#(U(#$X.C`W.C`W(&-H:6%R:R!K97)N96PZ("`@("`@("!F9F9F9F9F
M."!C-61E93`P,"!C-61E9F4V."!C,#$Q83`R,"!C9&,U,&1E8R`P,#`P,#`X
M,"!C-61E9F4V."`P,#`Q9F1D-R`*3V-T(#(U(#$X.C`W.C`W(&-H:6%R:R!K
M97)N96PZ($-A;&P@5')A8V4Z(%MH=6YG7W5P7W1T>5]R96%D*S`O,C1=(%M?
M7V9P=70K-C(O-S)=(%MF<'5T*S(S+S<R72!;;&]A9%]E;&9?8FEN87)Y*S$Y
M,S,O,CDW,ET@6V1O7V=E;F5R:6-?9FEL95]R96%D*S$T.3(O,34P-%T@6W)E
M861?97AE8RLS-C,O,S@P72!;<V5A<F-H7V)I;F%R>5]H86YD;&5R*S<Q+S$X
M.%T@"D]C="`R-2`Q.#HP-SHP-R!C:&EA<FL@:V5R;F5L.B`@("`@("`@6V1O
M7V5X96-V92LT,C4O-#DR72!;<WES7V5X96-V92LT-R\Y,ET@6W-Y<W1E;5]C
M86QL*S4R+S4V72`*3V-T(#(U(#$X.C`W.C`W(&-H:6%R:R!K97)N96PZ($-O
M9&4Z(&,W(#`U(#`P(#`P(#`P(#`P(#`P(#`P(#`P(#`P(#@S(&,T(#$P(#5B
4(#5E(&,S(#@Y(&8V(#4S(#AB(`H`
`
end
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
