Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272546AbRIKTgf>; Tue, 11 Sep 2001 15:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272540AbRIKTgS>; Tue, 11 Sep 2001 15:36:18 -0400
Received: from no-dns-yet.demon.co.uk ([62.49.236.27]:5625 "EHLO
	big-guy.sychron.com") by vger.kernel.org with ESMTP
	id <S272545AbRIKTgD>; Tue, 11 Sep 2001 15:36:03 -0400
X-Mailer: exmh version 2.0.3
To: linux-kernel@vger.kernel.org
Cc: P.Lister@sychron.com
Cc: Alan Cox <alan@redhat.com>
Reply-to: Peter Lister <P.Lister@sychron.com>
Subject: [PATCH] Process adoption (2.4.9 sched.h/fork.c/exit.c)
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_9514203340"
Date: Tue, 11 Sep 2001 20:36:17 +0100
From: Peter Lister <P.Lister@sychron.com>
Message-Id: <E15gtKT-0002LK-00@big-guy.sychron.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_9514203340
Content-Type: text/plain; charset=us-ascii

I attach a patch against 2.4.9 which implements process adoption. This
seems to be of general use; as searches of the kernel-traffic archives
have not thrown up anything similar, we'd like to contribute it. As
noted in http://www.tux.org/lkml/#s1-19, I'm cc'ing Alan Cox; just now
we're more interested in feedback from Alan and the list than immediate
acceptance by Linus. Should this prompt anyone to contribute a better
solution that Alan or Linus prefers, we're happy as long as it fixes the
daemon tracking problem. Useful feedback welcome: I'm sure there are
problems; please be gentle with a newbie contributor. :)

Functionality is similar to Solaris process lineage "orphan" fields,
though the terminology is changed, as noted in the patch to sched.h,
simply because the list includes processes which are NOT orphans. There
is no tainting by Solaris code - none of the authors have ever had
access to Solaris source.

Sychron uses this patch in kernels to support modules that track process
trees; primarily to find the grandparent of a daemon process, since this
is a common case which is hampered by the traditional behaviour that the
parent pid becomes 1 (init). With this patch, we can find who started
the original process. The existing parent pid logic is unchanged.

Before anyone comments - yes, I *do* know that there is no way to export
this information to user space. So far we haven't need to.

-- 
Peter Lister, Sychron Inc.  -  1-866-SYCHRON
Intelligent Infrastructure  -  www.sychron.com


--==_Exmh_9514203340
Content-Type: text/plain; name="patch.adoption"; charset=us-ascii
Content-Description: patch.adoption
Content-Transfer-Encoding: x-uuencode
Content-Disposition: attachment; filename="patch.adoption"

begin 644 patch.adoption
M26YD97@Z(&QI;G5X+T1O8W5M96YT871I;VXO0V]N9FEG=7)E+FAE;'`*/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/0I20U,@9FEL93H@+W5S97)S+W-Y8VAR;VXO
M8W9S<F]O="]L:6YU>"]$;V-U;65N=&%T:6]N+T-O;F9I9W5R92YH96QP+'8*
M<F5T<FEE=FEN9R!R979I<VEO;B`Q+C$N,BXQ,`IR971R:65V:6YG(')E=FES
M:6]N(#$N,2XR+C$P+C(N,@ID:69F("UU("UR,2XQ+C(N,3`@+7(Q+C$N,BXQ
M,"XR+C(*+2TM(&QI;G5X+T1O8W5M96YT871I;VXO0V]N9FEG=7)E+FAE;'`)
M,C`P,2\P."\R-"`Q,3HQ.3HR-0DQ+C$N,BXQ,`HK*RL@;&EN=7@O1&]C=6UE
M;G1A=&EO;B]#;VYF:6=U<F4N:&5L<`DR,#`Q+S`Y+S$Q(#$R.C(V.C`Q"3$N
M,2XR+C$P+C(N,@I`0"`M,3@T-C@L-B`K,3@T-C@L,3<@0$`*("`@5&\@=7-E
M('1H:7,@;W!T:6]N+"!Y;W4@:&%V92!T;R!C:&5C:R!T:&%T('1H92`B+W!R
M;V,@9FEL92!S>7-T96T*("`@<W5P<&]R="(@*$-/3D9)1U]04D]#7T93*2!I
M<R!E;F%B;&5D+"!T;V\N"B`**U!R;V-E<W,@861O<'1I;VX**T-/3D9)1U]0
M4D]#15-37T%$3U!424]."BL**R`@16YA8FQE<R!A9&1I=&EO;F%L('!R;V-E
M<W,@;&EN96%G92!C;V1E.R!W:&5N(&$@<')O8V5S<R!D:65S+"!I=',**R`@
M8VAI;&1R96X@87)E(&%D;W!T960@8GD@=&AE(&YE87)E<W0@<W5R=FEV:6YG
M(&%N8V5S=&]R+"!R871H97(@=&AA;@HK("!T:&%N(#$@*&EN:70I+"!T:&4@
M=')A9&ET:6]N86P@54Y)6"!F=6YC=&EO;F%L:71Y+@HK"BL@(%1H:7,@:7,@
M=7-E9G5L+"!F;W(@97AA;7!L92P@=VAE;B!T<F%C:VEN9R!D865M;VX@<')O
M8V5S<V5S('=H97)E"BL@('1H92!I;FET:6%L('!R;V-E<W,@9F]R:W,@82!C
M:&EL9"!A;F0@=&AE;B!E>&ET<R`M('1H92!O<G!H86YE9`HK("!P<F]C97-S
M(&ES(&%D;W!T960@8GD@:71S(&=R86YD<&%R96YT(')A=&AE<B!T:&%N(&EN
M:70N"BL*(",*(",@02!C;W5P;&4@;V8@=&AI;F=S($D@:V5E<"!F;W)G971T
M:6YG.@H@(R`@(&-A<&ET86QI>F4Z($%P<&QE5&%L:RP@171H97)N970L($1/
M4RP@1$U!+"!&050L($944"P@26YT97)N970L(`I);F1E>#H@;&EN=7@O87)C
M:"]I,S@V+V-O;F9I9RYI;@H]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]"E)#4R!F
M:6QE.B`O=7-E<G,O<WEC:')O;B]C=G-R;V]T+VQI;G5X+V%R8V@O:3,X-B]C
M;VYF:6<N:6XL=@IR971R:65V:6YG(')E=FES:6]N(#$N,2XR+C8*<F5T<FEE
M=FEN9R!R979I<VEO;B`Q+C$N,BXV+C(N,0ID:69F("UU("UR,2XQ+C(N-B`M
M<C$N,2XR+C8N,BXQ"BTM+2!L:6YU>"]A<F-H+VDS.#8O8V]N9FEG+FEN"3(P
M,#$O,#@O,38@,3@Z,S<Z-#@),2XQ+C(N-@HK*RL@;&EN=7@O87)C:"]I,S@V
M+V-O;F9I9RYI;@DR,#`Q+S`X+S(T(#$U.C(Y.C(T"3$N,2XR+C8N,BXQ"D!`
M("TQ.#4L-B`K,3@U+#<@0$`*(&UA:6YM96YU7V]P=&EO;B!N97AT7V-O;6UE
M;G0*(&-O;6UE;G0@)T=E;F5R86P@<V5T=7`G"B`**V)O;VP@)U!R;V-E<W,@
M061O<'1I;VXG($-/3D9)1U]04D]#15-37T%$3U!424]."B!B;V]L("=.971W
M;W)K:6YG('-U<'!O<G0G($-/3D9)1U].150*(&)O;VP@)U-'22!6:7-U86P@
M5V]R:W-T871I;VX@<W5P<&]R="<@0T].1DE'7U9)4U=3"B!I9B!;("(D0T].
M1DE'7U9)4U=3(B`](")Y(B!=.R!T:&5N"DEN9&5X.B!L:6YU>"]I;F-L=61E
M+VQI;G5X+W-C:&5D+F@*/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/0I20U,@9FEL
M93H@+W5S97)S+W-Y8VAR;VXO8W9S<F]O="]L:6YU>"]I;F-L=61E+VQI;G5X
M+W-C:&5D+F@L=@IR971R:65V:6YG(')E=FES:6]N(#$N,2XR+C8*<F5T<FEE
M=FEN9R!R979I<VEO;B`Q+C$N,BXV+C(N,0ID:69F("UU("UR,2XQ+C(N-B`M
M<C$N,2XR+C8N,BXQ"BTM+2!L:6YU>"]I;F-L=61E+VQI;G5X+W-C:&5D+F@)
M,C`P,2\P."\Q-B`Q.#HS-SHR,0DQ+C$N,BXV"BLK*R!L:6YU>"]I;F-L=61E
M+VQI;G5X+W-C:&5D+F@),C`P,2\P."\R-"`Q-3HR.3HR-`DQ+C$N,BXV+C(N
M,0I`0"`M-#`Q+#8@*S0P,2PV,"!`0`H@("`@"74S,B!S96QF7V5X96-?:60[
M"B`O*B!0<F]T96-T:6]N(&]F("AD92TI86QL;V-A=&EO;CH@;6TL(&9I;&5S
M+"!F<RP@='1Y("HO"B`)<W!I;FQO8VM?="!A;&QO8U]L;V-K.PHK(VEF9&5F
M($-/3D9)1U]04D]#15-37T%$3U!424]."BLO*B!04D]#15-3($%$3U!424].
M(&-O9&4@0V]P>7)I9VAT(%-Y8VAR;VX@26YC+B`R,#`Q("T@=W=W+G-Y8VAR
M;VXN8V]M("HO"BLO*B!04D]#15-3($%$3U!424].(&-O9&4@=V%S('=R:71T
M96X@9G)O;2!S8W)A=&-H('=I=&AO=70@<F5F97)E;F-E('1O"BL@*B!A;GD@
M<&%R="!O9B!3;VQA<FES(&]R(&%N>2!O=&AE<B!S;V9T=V%R92X@3F\@<F5F
M97)E;F-E('=A<R!M861E('1O"BL@*B!C;W!Y<FEG:'0@;6%T97)I86P@8F5L
M;VYG:6YG('1O(%-U;B!-:6-R;W-Y<W1E;7,L($EN8RX@;W1H97(@=&AA;@HK
M("H@<'5B;&EC;'D@879A:6QA8FQE(&EN9F]R;6%T:6]N+"!S<&5C:69I8V%L
M;'D@36%U<F\@86YD($UC1&]U9V%L;`HK("H@(E-O;&%R:7,@26YT97)N86QS
M(BP@*%-U;B!-:6-R;W-Y<W1E;7,@4')E<W,@+R!0<F5N=&EC92!(86QL($E3
M0DX**R`J(#`M,3,M,#(R-#DV+3`I"BL@*@HK("H@<%]N:W!T<B`@+2!.97AT
M($]F($MI;CL@<')O8V5S<R=S(&-L;W-E<W0@;&EV:6YG(&%N8V5S=&]R"BL@
M*B!P7V%D<'1R("`M($%D;W!T960@1&5S8V5N9&5N=',@*'-E92!B96QO=RD*
M*R`J('!?<&%S<'1R("T@4')E=FEO=7,@061O<'1E9"!3:6)L:6YG("AI;B!.
M97AT($]F($MI;B=S($%$(&QI<W0I"BL@*B!P7VYA<W!T<B`M($YE>'0@061O
M<'1E9"!3:6)L:6YG("AI;B!.97AT($]F($MI;B=S($%$(&QI<W0I"BL@*@HK
M("H@5&AE<V4@9FEE;&1S(&%R92!U<V5D(&)Y('1H92!A8V-O;7!A;GEI;F<@
M8V]D92!P871C:&5S('1O"BL@*B!K97)N96PO>V9O<FLL97AI='TN8R!T;R!I
M;7!L96UE;G0@<')O8V5S<R!A9&]P=&EO;B!I;B!A('-I;6EL87(**R`J('-T
M>6QE('1O(%-U;B=S(%-O;&%R:7,N($]R<&AA;F5D('!R;V-E<W-E<R!A<F4@
M861O<'1E9"!B>2!T:&5I<@HK("H@8VQO<V5S="!S=7)V:79I;F<@86YC97-T
M;W(L('=H97)E87,@=')A9&ET:6]N86P@52HJ6"!F=6YC=&EO;F%L:71Y"BL@
M*B`H<%]C<'1R+"!P7W!P='(L('!?>7-P='(L('!?;W-P='(I(&ES('1H870@
M;W)P:&%N('!R;V-E<W-E<R!A<F4**R`J(&%D;W!T960@8GD@:6YI="`H<&ED
M(#$I+B`@5VET:"!D865M;VYS+"!T:&4@:6YI=&EA;"!P<F]C97-S(&5X:71S
M"BL@*B!A;&UO<W0@:6UM961I871E;'D[(&UU8V@@8F5T=&5R(&EF('1H92!R
M=6YN:6YG(&1A96UO;B!C86X@8F4@=')A8V5D"BL@*B!B86-K('1O('1H92!S
M:&5L;"!W:&EC:"!I;G9O:V5D(&ET<R!P87)E;G0N"BL@*@HK("H@4V]L87)I
M<R!E<75I=F%L96YT<R!A<F4N+BX**R`J('!?;FMP='(@(#T@;F5X=&]F:VEN
M"BL@*B!P7V%D<'1R("`](&]R<&AA;@HK("H@<%]N87-P='(@/2!N97AT;W)P
M:`HK("H@6R!P7W!A<W!T<B!H87,@;F\@4V]L87)I<R!E<75I=F%L96YT+"!A
M<R!I=',@;&ES="!I<R!S:6YG;'D@;&EN:V5D(%T**R`J"BL@*B!P7V%D<'1R
M(&ES(&$@<&]I;G1E<B!T;R!A(&1O=6)L>2UL:6YK960@;&ES="`H<VEM:6QA
M<B!T;R!P7V-P='(I(&]F"BL@*B!T:&4@<')O8V5S<R=S(&1E<V-E;F1E;G1S
M('=H:6-H(&AA=F4@;F\@;W1H97(@;F5X="!O9B!K:6XN(%1H92!L:7-T"BL@
M*B!I;F-L=61E<R!T:&4@<')O8V5S<R=S(&]W;B!C:&EL9')E;B`H9'5P;&EC
M871I;F<@=&AE('!?8W!T<B!L:7-T*2P**R`J(&%N9"!O<G!H86YE9"!G<F%N
M9&-H:6QD<F5N(&%D;W!T960@=VAE;B!A(&-H:6QD(&1I960N("!3;VQA<FES
M)W,**R`J(")N97AT;V9K:6XB('-E96US(&$@<F5A<V]N86)L92!T97)M("T@
M;VYE(&ES(&YE>'0@;V8@:VEN('1O(&]N92=S"BL@*B!O=VX@8VAI;&1R96X@
M87,@=V5L;"!A<R!T:&]S92!O;F4@861O<'1S+B!(;W=E=F5R+"!3;VQA<FES
M)W,**R`J(")O<G!H86XB(&ES(&IU<W0@<&QA:6X@=W)O;F<@+2!O;F4G<R!O
M=VX@8VAI;&1R96X@87)E(&-L96%R;'D@;F]T"BL@*B!O<G!H86YS('=H:6QE
M(&]N92!L:79E<RX@(")$97-C96YD96YT(B!S965M<R!E<75A;&QY('=R;VYG
M+"!S:6YC90HK("H@9W)A;F1C:&EL9')E;B!W:71H(')U;FYI;F<@<&%R96YT
M<R!A<F4@9&5S8V5N9&5N=',@*&%S(&%R92`J=&AE:7(J"BL@*B!D97-C96YD
M96YT<RDL(&)U="!C;&5A<FQY('-H;W5L9"!N;W0@8F4@:6X@=&AI<R!L:7-T
M+B!792!U<V4**R`J(")!9&]P=&5D($1E<V-E;F1E;G1S(B`H041S*3L@:68@
M<F5G87)D:6YG(&]N92=S(&]W;B!C:&EL9')E;B!A<PHK("H@(F%D;W!T960B
M('-E96US(&]D9"P@8V]N<VED97(@=&AE;2!I;7!L:6-I=&QY(&%D;W!T960@
M870@8FER=&@@87,**R`J(&1I<W1I;F-T(&9R;VT@;W)P:&%N960@9W)A;F1C
M:&EL9')E;B!E>'!L:6-I=&QY(&%D;W!T960@;&%T97(N"BL@*@HK("H@<%]P
M87-P='(@86YD('!?;F%S<'1R(&1O(&YO="!H879E('1H92!S86UE('EO=6YG
M97(@86YD(&]L9&5R"BL@*B!S96UA;G1I8W,@87,@<%]Y<W!T<B!A;F0@<%]O
M<W!T<BX@4&]S:71I;VX@:6X@=&AE(&QI<W0@<F5F;&5C=',**R`J('=H96X@
M=&AE:7(@<&%R96YT(&1I960L(&YO="!T:&5I<B!C<F5A=&EO;B!T:6UE+"!S
M;R!T:&5Y(&%R90HK("H@<F5F97)R960@=&\@87,@<')E=FEO=7,@86YD(&YE
M>'0@=&\@9&ES8V]U<F%G92!A<W-U;7!T:6]N<R!A8F]U=`HK("H@86=E(&]R
M9&5R+B!P7V%D<'1R('!O:6YT<R!T;R!T:&4@;6]S="!R96-E;G1L>2!A9&]P
M=&5D('!R;V-E<W,[('1H90HK("H@;&ES="!I<R!T<F%V97)S960@=FEA('!?
M;F%S<'1R+"!S;R!T:&4@(FYE>'0B(&%D;W!T960@<VEB;&EN9R!W87,**R`J
M(&%D;W!T960@*F)E9F]R92H@:71S('!R961E8V5S<V]R+"!L:6ME('1H92!3
M;VQA<FES(&YE>'1O<G!H(&]R9&5R+@HK("H**R`J+PHK"7-T<G5C="!T87-K
M7W-T<G5C="`J<%]N:W!T<BP@*G!?9'!T<BP@*G!?<&1P='(L("IP7VYD<'1R
M.PHK(V5N9&EF"B!].PH@"B`O*@I`0"`M-#,W+#8@*S0Y,2PQ-B!`0`H@(V1E
M9FEN92!-05A?0T]53E1%4@DH,C`J2%HO,3`P*0H@(V1E9FEN92!$149?3DE#
M10DH,"D*(`HK(VEF9&5F($-/3D9)1U]04D]#15-37T%$3U!424]."BLC9&5F
M:6YE($E.251?5$%32U]!1$]05$E/3B!<"BL@('!?;FMP='(Z("@F:6YI=%]T
M87-K*2P@7`HK("!P7V%D<'1R.B!.54Q,+"!<"BL@('!?<&%S<'1R.B!.54Q,
M+"!<"BL@('!?;F%S<'1R.B!.54Q,+`HK(V5L<V4**R-D969I;F4@24Y)5%]4
M05-+7T%$3U!424]."BLC96YD:68**PH@+RH*("`J("!)3DE47U1!4TL@:7,@
M=7-E9"!T;R!S970@=7`@=&AE(&9I<G-T('1A<VL@=&%B;&4L('1O=6-H(&%T
M"B`@*B!Y;W5R(&]W;B!R:7-K(2X@0F%S93TP+"!L:6UI=#TP>#%F9F9F9B`H
M/3)-0BD*0$`@+30W.2PW("LU-#,L."!`0`H@("`@('-I9SH)"29I;FET7W-I
M9VYA;',L"0D)"0E<"B`@("`@<&5N9&EN9SH)"7L@3E5,3"P@)G1S:RYP96YD
M:6YG+FAE860L('M[,'U]?2P)"5P*("`@("!B;&]C:V5D.@D)>WLP?7TL"0D)
M"0D)7`HM("`@(&%L;&]C7VQO8VLZ"0E34$E.7TQ/0TM?54Y,3T-+140)"0D)
M7`HK("`@(&%L;&]C7VQO8VLZ"0E34$E.7TQ/0TM?54Y,3T-+140L"0D)"5P*
M*R`@("!)3DE47U1!4TM?041/4%1)3TX*('T*(`H@"DEN9&5X.B!L:6YU>"]K
M97)N96PO97AI="YC"CT]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T*4D-3(&9I;&4Z
M("]U<V5R<R]S>6-H<F]N+V-V<W)O;W0O;&EN=7@O:V5R;F5L+V5X:70N8RQV
M"G)E=')I979I;F<@<F5V:7-I;VX@,2XQ+C(N-`IR971R:65V:6YG(')E=FES
M:6]N(#$N,2XR+C0N,BXQ"F1I9F8@+74@+7(Q+C$N,BXT("UR,2XQ+C(N-"XR
M+C$*+2TM(&QI;G5X+VME<FYE;"]E>&ET+F,),C`P,2\P."\R-"`Q,3HQ-SHQ
M-@DQ+C$N,BXT"BLK*R!L:6YU>"]K97)N96PO97AI="YC"3(P,#$O,#@O,C0@
M,34Z,CDZ,C0),2XQ+C(N-"XR+C$*0$`@+30Q."PV("LT,3@L,S4@0$`*(`D)
M"7=R:71E7VQO8VM?:7)Q*"9T87-K;&ES=%]L;V-K*3L*(`D)?0H@"7T**R-I
M9F1E9B!#3TY&24=?4%)/0T534U]!1$]05$E/3@HK"2\J(%!23T-%4U,@041/
M4%1)3TX@8V]D92!#;W!Y<FEG:'0@4WEC:')O;B!);F,N(#(P,#$@+2!W=W<N
M<WEC:')O;BYC;VT@*B\**PDO*B!0;&5A<V4@<V5E(&EN8VQU9&4O;&EN=7@O
M<V-H960N:"`J+PHK"BL)+RH@4F5M;W9E(&-U<G)E;G0@9G)O;2!I=',@;F5X
M="UO9BUK:6XG<R!!9&]P=&5D($1E<V-E;F1E;G0@;&ES="`J+PHK"6EF("AC
M=7)R96YT+3YP7W!A<W!T<B`A/2!.54Q,*0HK"0EC=7)R96YT+3YP7W!A<W!T
M<BT^<%]N87-P='(@/2!C=7)R96YT+3YP7VYA<W!T<CL**PEE;'-E"BL)"6-U
M<G)E;G0M/G!?;FMP='(M/G!?861P='(@/2!C=7)R96YT+3YP7VYA<W!T<CL*
M*PEI9B`H8W5R<F5N="T^<%]N87-P='(@(3T@3E5,3"D**PD)8W5R<F5N="T^
M<%]N87-P='(M/G!?<&%S<'1R(#T@8W5R<F5N="T^<%]P87-P='(["BL**PDO
M*B!)9B!C=7)R96YT(&AA<R!A;B!!1"!L:7-T+"!P87-S('1H96T@=7`@=&\@
M8W5R<F5N="=S(&YE>'0@;V8@:VEN("HO"BL):68@*&-U<G)E;G0M/G!?861P
M='(I('L**PD)+RH@1F]R(&5A8V@@;V8@8W5R<F5N="=S($%$<RP@<V5T('1H
M92!N97AT(&]F(&MI;B!T;PHK"0D@*B`@(&)E(&ET<R`H8W5R<F5N="=S*2!N
M97AT(&]F(&MI;BX@("HO"BL)"7-T<G5C="!T87-K7W-T<G5C="`J<"P@*FQA
M<W1?040["BL)"69O<B`H<"`](&QA<W1?040@/2!C=7)R96YT+3YP7V%D<'1R
M.R!P.R!P(#T@<"T^<%]N87-P='(I('L**PD)"7`M/G!?;FMP='(@/2!C=7)R
M96YT+3YP7VYK<'1R.PHK"0D);&%S=%]!1"`]('`["BL)"7T**PD)+RH@3&EN
M:R!C=7)R96YT)W,@040@;&ES="!I;G1O(&ET<R`H8W5R<F5N="=S*0HK"0D@
M*B`@(&YE>'0M;V8M:VEN)W,@040@;&ES="`J+PHK"0EL87-T7T%$+3YP7VYA
M<W!T<B`](&-U<G)E;G0M/G!?;FMP='(M/G!?861P='(["BL)"6EF("AC=7)R
M96YT+3YP7VYK<'1R+3YP7V%D<'1R*0HK"0D)8W5R<F5N="T^<%]N:W!T<BT^
M<%]A9'!T<BT^<%]P87-P='(@/2!L87-T7T%$.PHK"0EC=7)R96YT+3YP7VYK
M<'1R+3YP7V%D<'1R(#T@8W5R<F5N="T^<%]A9'!T<CL**PE]"BLC96YD:68*
M(`EW<FET95]U;FQO8VM?:7)Q*"9T87-K;&ES=%]L;V-K*3L*('T*(`I);F1E
M>#H@;&EN=7@O:V5R;F5L+V9O<FLN8PH]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]/3T]
M"E)#4R!F:6QE.B`O=7-E<G,O<WEC:')O;B]C=G-R;V]T+VQI;G5X+VME<FYE
M;"]F;W)K+F,L=@IR971R:65V:6YG(')E=FES:6]N(#$N,2XR+C<*<F5T<FEE
M=FEN9R!R979I<VEO;B`Q+C$N,BXW+C(N,0ID:69F("UU("UR,2XQ+C(N-R`M
M<C$N,2XR+C<N,BXQ"BTM+2!L:6YU>"]K97)N96PO9F]R:RYC"3(P,#$O,#@O
M,38@,3@Z,S<Z,C`),2XQ+C(N-PHK*RL@;&EN=7@O:V5R;F5L+V9O<FLN8PDR
M,#`Q+S`X+S(T(#$U.C(Y.C(T"3$N,2XR+C<N,BXQ"D!`("TV,3`L-B`K-C$P
M+#$X($!`"B`)<"T^<G5N7VQI<W0N<')E=B`]($Y53$P["B`*(`EP+3YP7V-P
M='(@/2!.54Q,.PHK(VEF9&5F($-/3D9)1U]04D]#15-37T%$3U!424]."BL)
M+RH@4%)/0T534R!!1$]05$E/3B!C;V1E($-O<'ER:6=H="!3>6-H<F]N($EN
M8RX@,C`P,2`M('=W=RYS>6-H<F]N+F-O;2`J+PHK"2\J(%!L96%S92!S964@
M:6YC;'5D92]L:6YU>"]S8VAE9"YH("HO"BL**PEP+3YP7VYK<'1R("`](&-U
M<G)E;G0[("`@("`@("`@("`@+RH@0W5R<F5N="!I<R!T:&4@;F5W(&-H:6QD
M)W,@;F5X="!O9B!K:6X@("`@("`@("`@("`@("`@("`@("`J+PHK"7`M/G!?
M861P='(@(#T@3E5,3#L@("`@("`@("`@("`@("`O*B!4:&4@;F5W(&-H:6QD
M(&AA<R!N;R!!9&]P=&5D($1E<V-E;F1E;G1S("`@("`@("`@("`@("`@("`@
M("HO"BL)<"T^<%]P87-P='(@/2!.54Q,.R`@("`@("`@("`@("`@("\J(%1H
M92!N97<@8VAI;&0@:7,@9FER<W0@:6X@=&AE($%$(&QI<W0@*&YO('!R961E
M8V5S<V]R<RD@("`@*B\**R`@("`@("`)<"T^<%]N87-P='(@/2!C=7)R96YT
M+3YP7V%D<'1R.R`@("\J(%1H92!N97<@8VAI;&0G<R!S=6-C97-S;W(@:7,@
M=&AE(&AE860@;V8@8W5R<F5N="=S($%$(&QI<W0@*B\**PEI9B`H8W5R<F5N
M="T^<%]A9'!T<BD@("`@("`@("`@("`@+RH@268@8W5R<F5N="!H87,@86X@
M97AI<W1I;F<@040@;&ES="P@("`@("`@("`@("`@("`@("`@("`@("`J+PHK
M"0EC=7)R96YT+3YP7V%D<'1R+3YP7W!A<W!T<B`]('`[("\J("!T:&4@;F5W
M(&-H:6QD(&)E8V]M97,@:71S('!R961E8V5S<V]R("`@("`@("`@("`@("`@
M*B\**PEC=7)R96YT+3YP7V%D<'1R(#T@<#L@("`@("`@("`@("`@+RH@5&AE
M(&YE=R!C:&EL9"!B96-O;65S('1H92!H96%D(&]F(&-U<G)E;G0G<R!!1"!L
M:7-T("`@("`@("`J+PHK(V5N9&EF"B`):6YI=%]W86ET<75E=65?:&5A9"@F
M<"T^=V%I=%]C:&QD97AI="D["B`)<"T^=F9O<FM?9&]N92`]($Y53$P["B`)
A:68@*&-L;VYE7V9L86=S("8@0TQ/3D5?5D9/4DLI('L*
`
end


--==_Exmh_9514203340
Content-Type: text/plain ; name="README.adoption"; charset=us-ascii
Content-Description: README.adoption
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="README.adoption"

The accompanying patch is Copyright Sychron 2001

This patch implements process adoption; fields have been added to the
task structure and logic to the process creation/destruction (fork and
exit) functions to maintain a link to each process's nearest living
ancestor.

The traditional behaviour of the parent pid (set to 1 when the parent
dies) does not cope with daemons which outlive their (short lived)
parents.

Refer the annotation in sched.h for details.

Peter Lister
p.lister@sychron.com
11-Sep-2001

--==_Exmh_9514203340--


